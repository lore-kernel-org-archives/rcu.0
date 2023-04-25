Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F726C6FD18
	for <rcu@archiver.kernel.org>; Tue, 25 Apr 2023 20:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236280AbjDYU4E (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 25 Apr 2023 16:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjDYUzz (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 25 Apr 2023 16:55:55 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF5B146D3
        for <rcu@vger.kernel.org>; Tue, 25 Apr 2023 13:55:54 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-5ef4eba2598so28407726d6.3
        for <rcu@vger.kernel.org>; Tue, 25 Apr 2023 13:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682456153; x=1685048153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t7Lq9AtgPVpX1WBsnwrClM/8ZPqJK1zo+K2nGNjac2U=;
        b=qKvaYJ4wuMGPrRVSGWsHWG9l39H+wc8eGi5OsDQUW/8yDHtm+qsSZLFL7fjeqdHcQB
         speqH/esFsWE0pw24OhJExfEpvTMoHTxP8BpuQGrpBamCn0BsNI9OxF5wzko8oVEXyY9
         Ocx+RRxyuhtXOIxkcJQ4jjxfKV7IADaMmCgpPFIF3XvPKyDEM1+yks7V3kht1gO581Zb
         tx422hPop5IXBkBx6iUc6Fwz5wPSZjT+HhmaN/3Oy6edcxRJ/Hk6G2LdKtu6MKVP1PwW
         g4i+pUACllLMlcTgCxCMv++ZkLk0bK84HEMMZNGsaBr/YLjfY6AZZaA+jIB8F5HMXq/c
         KE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456153; x=1685048153;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7Lq9AtgPVpX1WBsnwrClM/8ZPqJK1zo+K2nGNjac2U=;
        b=JJBbzgG7dza4yE/EYKVaiZpNX+uiEZcyBEC4QhQ4m/XGPFVsIYJF+xgTTaw5u6hT06
         NwIaTVlsts2I6gdQhHAClqyjdkRQBGEFBVq/ZY48rYT6J/w+QET+QEHod/LvjFDTvVG7
         5Qg66USWFkjFXiowURtO87smAFnabXZjomGCBpDJRKkh+V1QmsoVToOwv6rTHDtzGqK6
         PGEzTtbtpXCrvBxGgiDrIYOQI7HbCPGtQ0k6bvEGma+aC8DzX4ukYGKxycYfXzIVxBYy
         sWbh8z1rYR5ZMW80xzMCWAAAQtdSCIPYDyIGWVL2qmJLjlFcFCd0GkddS7C05ajH6+lB
         uBxw==
X-Gm-Message-State: AAQBX9cqU1M0rhlFhettraHErDc7z/Mdw8A9kep337l8d4//C0kcKys+
        oLkVcdXgIIiXN9Z/05nxZXI=
X-Google-Smtp-Source: AKy350ZSacBLowiNt8UBJ1KFSmRGtFrPl8GbkFySSCYP9nl1+Az/Y57ujWSa/yhCETX9x8MluGgF8Q==
X-Received: by 2002:a05:6214:2523:b0:56e:b25f:3602 with SMTP id gg3-20020a056214252300b0056eb25f3602mr31934465qvb.43.1682456153140;
        Tue, 25 Apr 2023 13:55:53 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id ru5-20020a05620a684500b0074adc37ec46sm2916663qkn.84.2023.04.25.13.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 13:55:52 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id 2C40527C005C;
        Tue, 25 Apr 2023 16:55:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Apr 2023 16:55:52 -0400
X-ME-Sender: <xms:Vz5IZAVCj6LEwn_MWs_be4idIEA64cteqxch6M4hNpKbfc9MieBtVw>
    <xme:Vz5IZEm24WakXKdWxvEcsfHq5DzclL1OTFVwz-GI7Ilc7XNUclGEnz2Skq7F83jtr
    v4roa8UvIIIWxWW0w>
X-ME-Received: <xmr:Vz5IZEaLjOjdH4BqHmbdwBajk8xmiWqTBBYcc8fgxI2Q8CgywCo4i9nwH6M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddgudehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogfuuhhsphgvtghtffhomhgrihhnucdlgeelmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeejfeeftefgfedvvdfftdegheeiffevteelhfejledvhfellefggfff
    kefgudffueenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghu
    thhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqh
    hunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Vz5IZPWcY6b777JJ1tZKYjIFHxg8O-4-_VCLevHom9GJpwxm_rI5Zw>
    <xmx:Vz5IZKm2jbt6OONL7GCquvEK8w1kUfLj3gq0UeIhnEZiJ8wnQY4pUw>
    <xmx:Vz5IZEc4JaAd4g7j5FPEIx9TcN0wMDsY9iHSPmy5oYXZjr_HJWOlaA>
    <xmx:WD5IZMVkOc7eGWhjjPbJDNcsS15QMRsSqV16eEiXJt8Pjav-VHY16Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 16:55:51 -0400 (EDT)
Date:   Tue, 25 Apr 2023 13:55:11 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Yuvraaj Kelkar <uv@crave.io>
Cc:     rcu@vger.kernel.org, joel@joelfernandes.org, boqun.feng@gmail.com,
        frederic@kernel.org, quic_neeraju@quicinc.com, urezki@gmail.com,
        paulmck@kernel.org
Subject: Re: RCU Torture test failed at git commit 61d325dcbc05d8fef88110d35
Message-ID: <ZEg+L1bjyrpD9Zni@boqun-archlinux>
References: <CAHOZ0eADVgEPVEv-rBrF=E11v-4S4xnY1rej=MytLtSFperMFw@mail.gmail.com>
 <ZEclEg+1qeL4HkBm@boqun-archlinux>
 <CAHOZ0eCRZunDbX3YOy++31xrq60y3_ge=JJz5mbHAy+k6LfchQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHOZ0eCRZunDbX3YOy++31xrq60y3_ge=JJz5mbHAy+k6LfchQ@mail.gmail.com>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Apr 25, 2023 at 09:32:51AM -0700, Yuvraaj Kelkar wrote:
> I've been trying to attach logs to this email since yesterday, but the
> mailing list keeps rejecting my attempts.

FWIW, I actually review all the attachments in your previous emails, so
it looks like it's only the list which rejects you :/

> I've uploaded all the logs to my Google Drive:
> https://drive.google.com/drive/folders/1giTWAVnu-rmfEsb-vLQJSxtg6wmHnzeG?usp=sharing
> 
> I hope at least this link will be allowed by the system.
> 

I tried to reproduce this locally, unfortunately, I'm unable to
reproduce this yet. In the meanwhile, could you check if you can
reliably reproduce this? Hint, you can run only TREE03 with the
following command:

	kvm.sh --cpus 102 --configs "TREE03"

Thanks!

Regards,
Boqun

> Thanks,
> -Uv
> 
> On Mon, Apr 24, 2023 at 5:56 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Mon, Apr 24, 2023 at 05:00:25PM -0700, Yuvraaj Kelkar wrote:
> > > Hi RCU folks,
> > >
> > > We have a RCU torture test set up that has just reported a failure at
> > > commit ID 61d325dcbc05d8fef88110d35 on the Linux kernel.
> > > The command was: ./kvm.sh --cpus 102
> > > Logs are attached.
> >
> > Could you also share the TREE03 log:
> >
> >         /tmp/src/linux/tools/testing/selftests/rcutorture/res/2023.04.24-22.17.41/TREE03/console.log
> >
> > the build log basically said there is something wrong in that log.
> >
> > Regards,
> > Boqun
