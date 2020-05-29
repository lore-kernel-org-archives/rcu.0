Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D740AC433DF
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 05:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0232072D
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 05:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgE2FYt (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 01:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2FYs (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 01:24:48 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB7C08C5C8
        for <rcu@vger.kernel.org>; Thu, 28 May 2020 22:24:48 -0700 (PDT)
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04T5Olwd015999
        for <rcu@vger.kernel.org>; Fri, 29 May 2020 01:24:47 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04T5OgCu009458
        for <rcu@vger.kernel.org>; Fri, 29 May 2020 01:24:47 -0400
Received: by mail-qt1-f200.google.com with SMTP id y5so1605682qtd.0
        for <rcu@vger.kernel.org>; Thu, 28 May 2020 22:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=jkvjipyYBp2cx7ulrkRHJLvBj85Vc9PzxB3CdRuJTE0=;
        b=KFoT3QebRheT5kb7qKHq7rX/7bJkTk81XmzKFMvf9G/xIanNNPXm69kO3nW0ieklk/
         TMHCOe2pNqxPvsSzFhFXQx9uTpHKu6qgH4szOtcIt4KJSGcw6KvBskwoVcTpZFeiu4Vn
         Yx19zKHX0WoqiUsY0/pzpCX7p5K/TbYMf7HenE+hUsHo2x5NIDZs6uOVqyNs33662LvX
         zExKFVoFISoLs0oq+7XVW/gR0k14q5qgQ3AVS3Qmv+NB8P2SafzSawahtslQe/DQYdwG
         Yl7qKQTrL1Bp+ePU3LB8x5ZFC5lVPDlj5gZRJlDkRRAm2VhJ/QAX453CG3XcLwrt+lmo
         ilNA==
X-Gm-Message-State: AOAM533dXfD6zOwMHEN06APTyubje2cOwRnFhncDRR6hYeloExcsSrc9
        aiaO/2CsGmSo9Q2dQMmbTWMz0thPpiEYak6HHFO9ChtCCw77jHSSh/WPp2RBHY5l5avCWhieRkH
        RK7irnzznkR1NA3R8+HyK6x8=
X-Received: by 2002:ad4:46c7:: with SMTP id g7mr6408472qvw.245.1590729882244;
        Thu, 28 May 2020 22:24:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxi8Z+hMsbF6Kk1gntyoHLAHJpLnOfaCNP1t9tR2LMQEmiQVE+vv8RtgSQ4awqeoFIPRcQC4w==
X-Received: by 2002:ad4:46c7:: with SMTP id g7mr6408464qvw.245.1590729881857;
        Thu, 28 May 2020 22:24:41 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id a38sm7762287qtb.37.2020.05.28.22.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:24:40 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: next-20200528 - build error in kernel/rcu/refperf.c
In-Reply-To: <9d8b13db-9d77-416d-e283-9ea509ce43d1@infradead.org>
References: <538911.1590725791@turing-police>
 <9d8b13db-9d77-416d-e283-9ea509ce43d1@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590729879_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 01:24:39 -0400
Message-ID: <543040.1590729879@turing-police>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

--==_Exmh_1590729879_16657P
Content-Type: text/plain; charset=us-ascii

On Thu, 28 May 2020 21:48:18 -0700, Randy Dunlap said:

> > ERROR: modpost: "__aeabi_uldivmod" [kernel/rcu/refperf.ko] undefined!

Gaah.  And the reason I didn't spot Paul's post while grepping my linux-kernel
mailbox is because *that* thread had a different undefined reference:

> > > > > > m68k-linux-ld: kernel/rcu/refperf.o: in function `main_func':
> > > > > > >> refperf.c:(.text+0x762): undefined reference to `__umoddi3'

> Paul has already responded: (unfortunately)
>
> "So I am restricting to 64BIT for the time being.  Yeah, I know, lazy of
> me.  ;-)"

It's the sort of issue that's well into "as long as it gets mostly fixed before
it hits Linus's tree" territory.   I've seen lots of far worse work-arounds in
the years since the 2.5.47 kernel. :)






--==_Exmh_1590729879_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXtCclwdmEQWDXROgAQJkfg/6A2IcEFTV326dW0vwvyr6VfK1sfUL8g/W
O56/d3DjBFSNnr1RW6heKf4ZTCdcHar2T2BwYJwuheSyq8ZpPcfIyx6dCr/hM1qJ
q4015CW6Jwibk4DUng5JZ9RUzG016FKrzG0OSsnqsSy2iHZv6eEx78AKetKxxcY3
mGZUFqJT+gxHYJfFBErDTY0+vCjJZlPfTcWvM0OeVbs2EblYoZtXvOrk3K99RCrS
lymBP+EAz+Sd1eiqtH5tSSaip3UjL/5ap2bF5b/ro3gW01ICJofL9dgVH12f64om
wnRTXPy298y5CP7y1Jdxu74pdZ2auk1J6642o9bwQuYSG1j6gcTn8PIvn0JpdOfr
U76sXZhtSZ/9HSYBu0NB/G8qjhl6AtFWNNltVH1tRWZCiuwLikfFOLYZe2qkac3s
mzWuHQopJLKx1/ySr1sycuBDU94VDD6T+qkub36Ktp4cEk0G4VfFJSQIucswrcjo
a6jWLQnYszkOKfZ7GuQSfUqz+FzQIFOJFr+qzaeI1BngOeMDsj/9bjBxDRKpeGGZ
8Mn5MfXwq7qugzTnKGW/1XY9oWLPIt0qwYhSm/llPTCJSiSH8xgR8jfaG5EOgqu8
D90p1PM5pQxQaAQvs39HiAsFpeVHUhmIB6WOz6ismqDh6bSDrsVINt5Qbwc/CYro
fk97PVYmRvU=
=w36d
-----END PGP SIGNATURE-----

--==_Exmh_1590729879_16657P--
