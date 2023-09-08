Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FDEE57EF
	for <rcu@archiver.kernel.org>; Fri,  8 Sep 2023 10:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238053AbjIHK25 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 8 Sep 2023 06:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241067AbjIHK24 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 8 Sep 2023 06:28:56 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EAC42117
        for <rcu@vger.kernel.org>; Fri,  8 Sep 2023 03:28:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26ef24b8e5aso1476331a91.0
        for <rcu@vger.kernel.org>; Fri, 08 Sep 2023 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694168903; x=1694773703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jSd3aj8Cdss8etgMl5COTxjG8cpnDFS3h/yWYOSKUwo=;
        b=a6+g8lMhAwq45bbSp1MVTqjSTDy7j9Stt9F1T+oXaiOpnvMU7uRmtKOZKFBbCweT0r
         FaiHA5Uckpqz/s2/5cYrAkVWD9DBHpfGZl4FHcFEGqQcX85KftexQ6wI6NzeCa2umTwf
         gRsk6iIXPJ58RKJZtfPUFGT+kXNxOx4/O8iMlUjcV29onwdivAduEWj/x2HcBgIJpuFm
         TG1H9/aoawuIWKJZ9RqfG9bVjkUNOGbDTxv0Vn+c7UUWBoi9hrTQ7eW/KFql63TjzCQK
         1QXz/0XykWa5SCu9YBru+M+lKFug6hvLvQJmJvnFTcRDayKfVAIQD4JrleQ9apptKbD1
         U14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694168903; x=1694773703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jSd3aj8Cdss8etgMl5COTxjG8cpnDFS3h/yWYOSKUwo=;
        b=JKAY9vnLzTRyKWj5k+4c2WTRFrSacERO2RYcO93NVuEaJctHVUY8WVJO4h2dnQXBpI
         I7M6ZvSW6h+A5GlhY3tWwFzh+k2ghxrnTRGbP1023n+gi3CQ8q4pNcja0G7fQ/2fEBgY
         ugCbCA3Mf9kbBFqt196lG7d1MTyr7WpM+DKHgynaHR4R+0c8Pp+w7XEaIuv8UnAoUdfJ
         7K6J9p1enbd8MPX35zyy0kIsT1g749j+l38kvbSajKIPAudaR4VSTTTTCMnjBIaaxjgi
         5rYosqBsDmeRUuOnzq5aFYFfwNvZF0XJhYmHz3AtPPyvzR0MMSSX8jeF+qGQke5SnowA
         2BOg==
X-Gm-Message-State: AOJu0Yx6PdlobkLaO/uzIalAAKcrz0QmWkfN5bxACMhytseZQybh7leW
        OQj2n4ovc5hXAKwlEgGed/ps86Gsofd/rftRp/I=
X-Google-Smtp-Source: AGHT+IFEfDmLL7JDapS/pUfiYQ2vzdILC6gWx6Gy+2w5ZlBIJ1lLl8FlinGNomHld4G3SapSvVZC7u0Do7iO3xxC+qY=
X-Received: by 2002:a17:90a:4315:b0:268:3d4:24bb with SMTP id
 q21-20020a17090a431500b0026803d424bbmr2278491pjg.1.1694168902706; Fri, 08 Sep
 2023 03:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAJWu+ooLBjAhZbHa+64egmh53-n7qc_o+PvsfSt2hzQNrVhdqw@mail.gmail.com>
 <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
In-Reply-To: <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Fri, 8 Sep 2023 18:28:11 +0800
Message-ID: <CAABZP2yFk=boa6UypsccRKr2TGpJq+a1odmibKNDHVNRz6c1-Q@mail.gmail.com>
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state RTWS_COND_SYNC_FULL
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Fri, Sep 8, 2023 at 1:59=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes wrote:
> > Hi,
> > Just started seeing this on 6.5 stable. It is new and first occurrence:
> >
> > TREE04 no success message, 234 successful version messages
> >  [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
> > [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
> > f0x0 ->state 0x2 cpu 6
> > [   38.388342] Call Trace:
> > [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
> > f0x2 ->state 0x2 cpu 6
> > [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
> > f0x0 ->state 0x2 cpu 6
> > [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g10505
> > f0x0 ->state 0x2 cpu 6
> > [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g13781
> > f0x0 ->state 0x2 cpu 6
> > [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g16544
> > f0x0 ->state 0x2 cpu 6
> > [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g18941
> > f0x0 ->state 0x2 cpu 6
> > [..]
> >
> > All logs:
> > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.y=
/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/TRE=
E04/
>
> Huh.  Does this happen for you in v6.5 mainline?
Hi, I am started torture.sh in a kvm environment (with nested kvm
enable) in my Intel  i7-1165G7 laptop, which can be examined at
runtime:
http://154.220.3.120:8080/test/linux-stable/tools/testing/selftests/rcutort=
ure/res/2023.09.08-10.23.47-torture/

Hope I can be of some beneficial
Thanks
Zhouyi
>
> Both the code under test (full-state polled grace periods) and the
> rcutorture test code are fairly new, so there is some reason for general
> suspicion.  ;-)
>
>                                                         Thanx, Paul
