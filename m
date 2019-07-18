Return-Path: <SRS0=SMg2=VP=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFBAC7618F
	for <rcu@archiver.kernel.org>; Thu, 18 Jul 2019 21:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9A921019
	for <rcu@archiver.kernel.org>; Thu, 18 Jul 2019 21:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p4GGsZS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbfGRVJ7 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 18 Jul 2019 17:09:59 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:42347 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfGRVJ7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 18 Jul 2019 17:09:59 -0400
Received: by mail-lf1-f49.google.com with SMTP id s19so20232488lfb.9
        for <rcu@vger.kernel.org>; Thu, 18 Jul 2019 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BiwbvIf2E7UeHN/qIeJzBVwubFLsFnVJKQ4SGUt+nxE=;
        b=p4GGsZS1Oj0uO76AWEWBUnn/j2vBG4YeRWYhY6CScnX7iUSsJ0C5f/Np7Cp00/+sod
         dALJYlE4WpVgWtiYMbe8XcAFe4RM4qzEPLOvXEdNxWslRc8dUUonVK1GQ0BmuJYRJm8F
         yY5FgxImfY/QdMRQ0K2eqEx7Hh46AO/qE6Fig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BiwbvIf2E7UeHN/qIeJzBVwubFLsFnVJKQ4SGUt+nxE=;
        b=lfVk6uGzFk2OHi8oXs8Li4gpacfoCPuiXrEbqn/h2Bocbq3MYaTs0Ctitx3DkYh8vA
         fE5uyX0hGqA1F5p1ygZThdLBYzx1OtRKEPbvxV0erpbJYsC+p1YoRCd30piWi4FW2YAn
         HpU49t/H59PW16O/0Q7fuFl/hLlJPdKerXCDyx/R4gmwktf94Wn/ChjD9J7tCRgSYKYq
         5THf0eanm9xqnTqUQVb70+byEInkK0MsulFAdMUNeNG+EWUjxX4qVp/B3UMxKeodeGO8
         5AAN3hcokvOJZms5+sb+nehdff0Y8FuFoHguGv4gkhkX0kzF6TDm53qFDfshY/EzYE/I
         SzYQ==
X-Gm-Message-State: APjAAAVLKJJOLd83ZyzG6rKudG6eDXYPJFt5Yq8Hg+a5tm+A+rUMMcK0
        Egqfu+AlmItWJLCZwVc0fULbDB1Lh25HZHoI5ONHNUnt
X-Google-Smtp-Source: APXvYqx/8NQE97aOlobZ88gVPC1hMNhoEjQhH4i9kPa7Duebm51E21m905Zf52PMo5LT4qBgl50Ziwz+bCwldimwvZg=
X-Received: by 2002:a19:ccc6:: with SMTP id c189mr21906432lfg.160.1563484196861;
 Thu, 18 Jul 2019 14:09:56 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 18 Jul 2019 17:09:45 -0400
Message-ID: <CAEXW_YR39bnCCj+eo30jSZrNEvcJY8wrXuA0fYr_gfbfNiVsPQ@mail.gmail.com>
Subject: This percpu_rwsem that always enters its reader slow path
To:     rcu <rcu@vger.kernel.org>
Cc:     Byungchul Park <byungchul.park@lge.com>
Content-Type: text/plain; charset="UTF-8"
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hello friends,

Just providing an update on my debugging of percpu_rwsem (related to
rcu-sync) for the day! which I pinged Byungchul about. Please ignore
this email if you are busy :) I am just archiving it in here..

As you may know, percpu_rwsem uses rcu-sync framework to reduce cost
of read-side by making it free of any serializing/atomic instructions
at all. However, there was one sempahore which broke the rules!

I spent a couple hours trying to figure out why
cgroup_threadgroup_rwsem always entered the reader-slow path on my
system (RCU-sync turns out to be non-idle for this rwsem). I really
thought it was a bug, because I felt what's the pointed of rcu-sync if
it never goes idle..

Then I landed on the commit below, and turns it was done for Android
and reported by John :) And the patch author was a certain guy named
Peter :)

commit 3942a9bd7b5842a924e99ee6ec1350b8006c94ec
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Thu Aug 11 18:54:13 2016 +0200

    locking, rcu, cgroup: Avoid synchronize_sched() in __cgroup_procs_write()
-----------

Basically, this commit makes the read-side cost percpu_rwsem slightly
more expensive (one smp_load_acquire of readers_block, at the cost of
making write-side a bit more expensive...)

So turns out it is weird, but it is certainly not a bug.

Learned something new but wasted my time a bit :)

Cheers, and see you later,
- Joel
