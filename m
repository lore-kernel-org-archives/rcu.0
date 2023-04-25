Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CEEC7618E
	for <rcu@archiver.kernel.org>; Tue, 25 Apr 2023 00:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjDYA42 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 24 Apr 2023 20:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDYA41 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 24 Apr 2023 20:56:27 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F2BAD19
        for <rcu@vger.kernel.org>; Mon, 24 Apr 2023 17:56:26 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-3ef639004d4so28365611cf.1
        for <rcu@vger.kernel.org>; Mon, 24 Apr 2023 17:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682384185; x=1684976185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mkp3KUvTCQancUYdYFT6AF6ObBwCVo35ozILOQ4BcIc=;
        b=D04D1Rg920ebpAnxaFawnMxenRwWbGluSPM6HR0iywibiIBAU9ATUlVm0Hrao6AMNq
         Xv82b0LzRDBvYfUWb0am8Gt1+/OGotoeTdUSyuTVzDW3NodS1TGgnoTZoQFNST4qipe8
         fIpZImLsobxKgJikLI2Myyh/tweQ/nMnuxDazkSc25SxRxuIuCemIPSUinhuZIzt77SF
         V0ajCCa0d3UXfw4cT5+X4Gsq4sjKCGrzVX+thIXna+RX9fpXGVX9w7vd9H376Ru77S4k
         25FaV+lwuBUAU8CyvQUd4vtBxvBvRCCJ5lhjQ15qm3UeYFV8fFdBxTMPvNT4PFNsBmUO
         gonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682384185; x=1684976185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mkp3KUvTCQancUYdYFT6AF6ObBwCVo35ozILOQ4BcIc=;
        b=atHVFXx8wBMozSwONr/lnOPT1tNHi15E0gOCpm6jzPCw+XvWh2lW0N8WytVu9ODQ85
         2xyGU78HbYmZyKSarfMqPqYtOVsj5LEL6OX7HSjSQLHT6T4h++muRRJOWC3PUWmot0Vj
         Qcj0rqLCJQAs3dF7bJbUbbvzWw9/GOaANqCpqyuKx9m8U/7f87C4sb5UsqsCWfkB352T
         FpEdZtHqQ+F4+BW2hcEFBwSuHLpWlt2ECbwJb2yK3w12uQd7cmFpbahnNzJ2savvG84W
         StFiJv2W1/LYWYnjyhzKpFrKQ3pUBLLb8shbaZF/orn13aYLMjSu8VGPp5ZTjwQaLKCW
         sSyA==
X-Gm-Message-State: AAQBX9fTGCB+T4E3Eu9mz0lXi7guLfEMM8zOp+jEejz8UHFjMAVsKhnD
        Wt5f/iR9QAx90EbLl0CyvTYfkWCtWk4=
X-Google-Smtp-Source: AKy350YQe0edTk1+6IDqfUlsmMcV4nnHMO0GmEbw6hVSXJjT5tSu6S+F2C9Zx2ZXpljcXA5NiWYEiQ==
X-Received: by 2002:ac8:5b04:0:b0:3ef:5b55:10d3 with SMTP id m4-20020ac85b04000000b003ef5b5510d3mr19914568qtw.63.1682384185615;
        Mon, 24 Apr 2023 17:56:25 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id do54-20020a05620a2b3600b0074e13ed6ee9sm3920404qkb.132.2023.04.24.17.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 17:56:24 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 8F73427C005A;
        Mon, 24 Apr 2023 20:56:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 24 Apr 2023 20:56:24 -0400
X-ME-Sender: <xms:OCVHZI4AK0xIzoXuIYZTfykf52iDEPn6tT14418TsKbKjmPHbL2K5g>
    <xme:OCVHZJ7srP_Mq4OLF2l0f-7xoQzpSeV7ZygaStv3CEbNoIKRuDUQbx25S70PTPTOX
    mwEPvDP4hViQYTuqg>
X-ME-Received: <xmr:OCVHZHcLP1YDXrP8C_MZCCbWNvkhRFbM2PEkJ5AwjonvcHWUtbKiCkFUBY8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduuddggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghes
    ghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuve
    elvdfhleelieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgv
    nhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:OCVHZNI3vGV5JwiTLptfaA9DEEXXDQA98CR83B8gLgbf7Z079jHllw>
    <xmx:OCVHZMI0JjkqOy1xSf63XKM6KI6i9CfcY8TuB1LsW9dL9Sbkvjg8FQ>
    <xmx:OCVHZOxeaQj8GInhFRoxicCFa3DQxOo2pem40Q0nqudrqVfosezAsg>
    <xmx:OCVHZGirn55D9Q41O1-RR0tBBvVCFFKcTu-8VITMGY0niFnHldImaA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Apr 2023 20:56:23 -0400 (EDT)
Date:   Mon, 24 Apr 2023 17:55:46 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Yuvraaj Kelkar <uv@crave.io>
Cc:     rcu@vger.kernel.org
Subject: Re: RCU Torture test failed at git commit 61d325dcbc05d8fef88110d35
Message-ID: <ZEclEg+1qeL4HkBm@boqun-archlinux>
References: <CAHOZ0eADVgEPVEv-rBrF=E11v-4S4xnY1rej=MytLtSFperMFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHOZ0eADVgEPVEv-rBrF=E11v-4S4xnY1rej=MytLtSFperMFw@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Apr 24, 2023 at 05:00:25PM -0700, Yuvraaj Kelkar wrote:
> Hi RCU folks,
> 
> We have a RCU torture test set up that has just reported a failure at
> commit ID 61d325dcbc05d8fef88110d35 on the Linux kernel.
> The command was: ./kvm.sh --cpus 102
> Logs are attached.

Could you also share the TREE03 log:

	/tmp/src/linux/tools/testing/selftests/rcutorture/res/2023.04.24-22.17.41/TREE03/console.log

the build log basically said there is something wrong in that log.

Regards,
Boqun

> 
> Thanks,
> -UV


