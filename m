Return-Path: <SRS0=sv12=BS=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_20,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E5CC433DF
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 18:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C1C206CD
	for <rcu@archiver.kernel.org>; Sat,  8 Aug 2020 18:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWzE7ZiI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgHHSVp (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 8 Aug 2020 14:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHHSVp (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 8 Aug 2020 14:21:45 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB0C061756
        for <rcu@vger.kernel.org>; Sat,  8 Aug 2020 11:21:44 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id v12so5486389ljc.10
        for <rcu@vger.kernel.org>; Sat, 08 Aug 2020 11:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oWp/0qhi/wtITsHPqIt/GcOWfTZYuiTPS29Q2O1Tv4I=;
        b=YWzE7ZiIosnbR14YGr/60ApOshQjjVvEUfPp8sEJVRLd/xYE0LvtJDCu+7TMmpQP6Q
         MzEvTFVgVEAHbPwXUpec4ckVLOscd1p+EBhK3/B+TkDd/f1X4B5uSPM81sTxiEdTiL5A
         3+ap3OFxBTUV+MWIMe9IcELHbnilS2hX+Ejq2acoSC7bHncVJ2JYW6K5iKkWv6N4tTci
         GaMmiANd+azyMj6GGOhvPcj8t440pvx4muIfa7dfIxzPRGFCHAUzwzeW4SYgg9EfcZuc
         bypnY/kTgVqcCnXS4gzn2lEV8Oib+skJE4MXF/cpqoQXX5YbYEAn+rz9OGnpNgiZWyDo
         lMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oWp/0qhi/wtITsHPqIt/GcOWfTZYuiTPS29Q2O1Tv4I=;
        b=q8p9g3+5taV7LoTGwwKtluaKpZqs8Kp9rswLnPQ/MEp9eT1j/bhFNmVueVPWlZh+sc
         lZb4spceG9AGPcIIp9i9zVbaM9EIQP1zdtt2hk0Wsj/3bCzZ1HsUFVMqqpNy5KXEU5H1
         zwWp/YeU/radlQSGInWvOsNs5IDYB6bMYQ9ocRVqBGiBME78EoXGxesktuLhaeb4u0O+
         eLURPWq5Mcl4fQJFglM0hYeEQWxAdiZxSLpiFKuGxwCbAzeqxHVhHtWuy0GFQZEws4bj
         HNqJbT1VJ6YHBnvCgG1j+2nko7j3S84kEF2Zczcad2Nq1R4n3MH554Z0rKf37G/y6tCK
         CseQ==
X-Gm-Message-State: AOAM531DwmZKAmcab+Jq6iTS1ek5QlviKC01753ISsfIXm3zReP+OFWQ
        ZrRjr8MgRbhvUeR3fqtEkRd33l+4QXBf4yjR+U95Bdkx
X-Google-Smtp-Source: ABdhPJyBaWhfDoOD3b1fGLHhyvI9BVsoqO6z1melH7AOl4bl8ICz4G7xt5cwg5L5qiP9mZOCNaoQjENw2VacioKxqwM=
X-Received: by 2002:a2e:9dd0:: with SMTP id x16mr8549658ljj.144.1596910903001;
 Sat, 08 Aug 2020 11:21:43 -0700 (PDT)
MIME-Version: 1.0
From:   William Tambe <tambewilliam@gmail.com>
Date:   Sat, 8 Aug 2020 13:21:31 -0500
Message-ID: <CAF8i9mNFFrSqfoREnQoR-vrt+b_auq=xd9-yEP0eK-q1J-PvwA@mail.gmail.com>
Subject: delayed_put_task_struct() used through call_rcu() by
 put_task_struct_rcu_user() never gets called
To:     rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

I am having an issue in my kernel where delayed_put_task_struct() used
through call_rcu() by put_task_struct_rcu_user() never gets called.

Any idea ?
