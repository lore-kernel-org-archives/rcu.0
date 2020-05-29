Return-Path: <SRS0=efVp=7L=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BF20C433DF
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 04:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297DA207D3
	for <rcu@archiver.kernel.org>; Fri, 29 May 2020 04:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgE2EQo (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 29 May 2020 00:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgE2EQn (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 29 May 2020 00:16:43 -0400
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51F6C08C5C8
        for <rcu@vger.kernel.org>; Thu, 28 May 2020 21:16:41 -0700 (PDT)
Received: from mr3.cc.vt.edu (mr3.cc.vt.edu [IPv6:2607:b400:92:8500:0:7f:b804:6b0a])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 04T4GdqM008791
        for <rcu@vger.kernel.org>; Fri, 29 May 2020 00:16:39 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr3.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 04T4GYRQ012639
        for <rcu@vger.kernel.org>; Fri, 29 May 2020 00:16:39 -0400
Received: by mail-qt1-f198.google.com with SMTP id z29so1454597qtj.5
        for <rcu@vger.kernel.org>; Thu, 28 May 2020 21:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version
         :content-transfer-encoding:date:message-id;
        bh=AxImIuZw0Xc1fI893sOoM6bfzHzhBthxYqedLKLYczs=;
        b=I1/T27FPen0rUEnj3pVlYtYngqkMd+T3MUPC0x9+OezqzrfGjcQV28nnlhCAf4uAIr
         JVmoM03tzN/zWditnMD+fIOgM58YLnKTQzyMsX9l9Lti5n4ZhZJ9Vvux+XMGZMlcUWxb
         wTekNk+5RKJpTS/IdXscQjZgpgwDzo7lK/+Yvjalv/8xhn7vxIKyievbawaod5wiLuTY
         YPrhe0i7birY+c0lCBE3gza+EPOfctkBHhLHYIK/d2cUNpQMyT84I9BYNoySN2ynW+CW
         3Amb9gMII8TZM7e8JUXV4dk/nFX+hgUgS1qcHzXDUDoJo1AXfnuuiwh/Hp7MzBXUCCCJ
         cfUg==
X-Gm-Message-State: AOAM530SEUALgEXgvGPrfatvAxz7jB2+qWKZ9x46Zf5Ux4phk1mPJHph
        meMu6a++cjLmSiaOqCWzJGjUITssue7jhHj8fuj0A8FvJjvJkkFFBtbLjeClaJsxQzF+v6+WkyW
        rD6uiYj2rY06jt68JQCsI2F8=
X-Received: by 2002:a05:620a:204d:: with SMTP id d13mr3961136qka.440.1590725794052;
        Thu, 28 May 2020 21:16:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwylGkbQkpKBwN9Hxm3hLi1y+Q2nzoPFTPJC4/EVqadyW3+hHXvOBEpDFCcJn4ujzN4BW+Z6g==
X-Received: by 2002:a05:620a:204d:: with SMTP id d13mr3961123qka.440.1590725793669;
        Thu, 28 May 2020 21:16:33 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id n85sm6608670qkn.31.2020.05.28.21.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 21:16:32 -0700 (PDT)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: next-20200528 - build error in kernel/rcu/refperf.c
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1590725791_16657P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 May 2020 00:16:31 -0400
Message-ID: <538911.1590725791@turing-police>
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

--==_Exmh_1590725791_16657P
Content-Type: text/plain; charset=us-ascii

commit 9088b449814f788d24f35a5840b6b2c2a23cd32a
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Mon May 25 17:22:24 2020 -0700

    refperf: Provide module parameter to specify number of experiments

changes this line of code (line 389)

-               reader_tasks[exp].result_avg = 1000 * process_durations(exp) / ((exp + 1) * loops);
+               result_avg[exp] = 1000 * process_durations(nreaders) / (nreaders * loops);

On a 32-bit ARM make allmodconfig with gcc 8.3, this results in:

ERROR: modpost: "__aeabi_uldivmod" [kernel/rcu/refperf.ko] undefined!
make[1]: *** [scripts/Makefile.modpost:103: __modpost] Error 1

I admit not understanding why the original line of code worked and the new one doesn't.
Maybe gcc is smarter/dumber about the ranges of 'exp' and 'nreaders' than we thought?

--==_Exmh_1590725791_16657P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXtCMngdmEQWDXROgAQI7MA/+PaUvCN+J+yGgfNRmfThCGdLitHgMT/pM
3l8r1S3bKK+IO2sB/SAGJg2VfEXDfpsNqMnQ3xq/qzXIVhz398DoUQsbXFVJlXxd
Z/weNlo014uQI6zQ/lmZgM8lPJbGf7gKbQdubVYEjopITztw7+wZ44v+lcup9Ju5
15KdCT5dsUlR8osTEVheW778uZNcEAuJDXhmiHT+Rf8+4ae/MIVEllen/nZ7lE4w
NUCO5IvFSM6bEt4WiVobZCUeapvirIJ16b0djsq9zT8FJOKQVFuodSXUVws9+TzG
fbYnsS7QRQsOAwcDP/FctWtlth1o1oxQ+j/xnv4DmWj2CCX1ssLRpUvEisYNUA4y
4VrSOgIuAZej5vSVchKAVzuVmC724fTA+pEWQjfbr26a537hgG6C8qnHVsqHuhMV
iN+E8Eof5QFhxRW+pQpEA0l09CZGCCFJt1O07d40pWKzlA0lW1/BKfpxikebrVUW
yhcDOWVI96vSi2Sg/6bO1M3PaLMS9smXMxAeLwf5JTJ0+KbSjlEYuAZyD2FKGcFy
W7P0gsaKj3d7wXCEIJTKq6EidnmVGwGym2J6Ceex1cocf1izxgajF6UDxRhAqoaD
NYjhWFgZUvT9Yo8IHzY7peaolq1csokzlYDUDKGFQQJ+s8IOsDc03OsMW3+O7li/
D0aWKEiEAaE=
=o/84
-----END PGP SIGNATURE-----

--==_Exmh_1590725791_16657P--
