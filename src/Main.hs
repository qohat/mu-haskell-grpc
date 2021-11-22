{-# language FlexibleContexts      #-}
{-# language PartialTypeSignatures #-}
{-# language OverloadedStrings     #-}
{-# OPTIONS_GHC -fno-warn-partial-type-signatures #-}
{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE DataKinds #-}
{-# language OverloadedLabels #-}

module Main where

import Schema

import Mu.GRpc.Server
import Mu.Server

main :: IO ()
main = runGRpcApp msgProtoBuf 8080 server

server :: MonadServer m => SingleServerT i Service m _
server = singleService (method @"SayHello" sayHello)

sayHello :: (MonadServer m) => HelloRequestMessage -> m HelloReplyMessage
sayHello (HelloRequestMessage nm) = pure $ HelloReplyMessage ("hi, " <> nm)


-- sayHello :: (MonadServer m) => HelloRequestMessage' -> m HelloReplyMessage'
-- sayHello (HelloRequestMessage nm) = pure $ record ("hi, " <> nm ^. #name)