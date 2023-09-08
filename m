Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D1AEB8FB1
	for <rcu@archiver.kernel.org>; Fri,  8 Sep 2023 00:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjIHAwB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Sep 2023 20:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbjIHAwA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Sep 2023 20:52:00 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844791BD7
        for <rcu@vger.kernel.org>; Thu,  7 Sep 2023 17:51:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bcfd3220d3so25494321fa.2
        for <rcu@vger.kernel.org>; Thu, 07 Sep 2023 17:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694134315; x=1694739115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7OMMPDW+mI4K+YJ8JDZ71Y9UC9WBZXlcaElTclcn6I=;
        b=MJPB0fKTCSfbzirO661fogjSr+0vcwZ95RT7/1FTaCch/vjSdAXkO3fLdMLFsZq699
         yl2J+pe+lfGIW42jGu5ueFIF3YNnDxqkGsYVc24RvB6pdTIXiuzFZ+GL7LNG918ezR+n
         8Dq2l3rHf90M1QScM0Njr5UzF8KSzptNCOajs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694134315; x=1694739115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7OMMPDW+mI4K+YJ8JDZ71Y9UC9WBZXlcaElTclcn6I=;
        b=dtNL51D57jDekStY0zJhf29JRp0iPVU3EJy1JDundeq68PqgYFKUvikwUwUru2o1Z3
         328ywP9ogm12kM6ZkCSJ4n+whm4r/MNbuhS1YXk4mNllcD0V8LgjHQph/QL2XfZiL3lq
         s2HhB5WdD1uJrw4ff1TXzvT1OhchitZKH0ig99ASqpAU7iSVV1kEmZi48hUhFz1aP1gw
         kVuuFiU8kk6LbjJfBBeW4P/hNKmmmPc+Y7VUpEBHb2ptfb8QDrhP8z0JBrLV1UoH33+o
         ELR4QECXuzTQi5Y7pt21/a6pPax21I7ALbZI1sQxEYI3+eMU+t61PSN6Wwp/6Z9cylyN
         w/Iw==
X-Gm-Message-State: AOJu0YwXghQro2dlDhnbwO0zXCKZrhO1ojSSaDfaz2l3N439QhULNuI4
        +1W51ynSM/VxFMv7z8wL7bKKVm1UuIYmACkj7JelSj3LLOY34/Bp
X-Google-Smtp-Source: AGHT+IF7MLWXXtTIMex2bGfLcDq6C5PlAxBzP5GWQkuHb+yxE7tZVnGTOPewsiI6+1528hxvqNkk0pGw0KAsAS5hcIQ=
X-Received: by 2002:a2e:8950:0:b0:2bc:dcdb:b5dc with SMTP id
 b16-20020a2e8950000000b002bcdcdbb5dcmr651443ljk.39.1694134314592; Thu, 07 Sep
 2023 17:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop> <FFC37117-94F4-49EC-86D7-508753C48A11@joelfernandes.org>
In-Reply-To: <FFC37117-94F4-49EC-86D7-508753C48A11@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 7 Sep 2023 20:51:43 -0400
Message-ID: <CAEXW_YStFf6Lt43GiLMCO5wBwCJU3aWcv5GvX0_8xaeZTFKMkA@mail.gmail.com>
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state RTWS_COND_SYNC_FULL
To:     paulmck@kernel.org
Cc:     Joel Fernandes <joelaf@google.com>, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 7, 2023 at 4:03=E2=80=AFPM Joel Fernandes <joel@joelfernandes.o=
rg> wrote:
>
>
>
> > On Sep 7, 2023, at 12:23 PM, Paul E. McKenney <paulmck@kernel.org> wrot=
e:
> >
> > =EF=BB=BFOn Thu, Sep 07, 2023 at 09:17:15AM -0400, Joel Fernandes wrote=
:
> >> Hi,
> >> Just started seeing this on 6.5 stable. It is new and first occurrence=
:
> >>
> >> TREE04 no success message, 234 successful version messages
> >> [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
> >> [   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
> >> f0x0 ->state 0x2 cpu 6
> >> [   38.388342] Call Trace:
> >> [   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
> >> f0x2 ->state 0x2 cpu 6
> >> [   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
> >> f0x0 ->state 0x2 cpu 6
> >> [   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g10505
> >> f0x0 ->state 0x2 cpu 6
> >> [   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g13781
> >> f0x0 ->state 0x2 cpu 6
> >> [  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g16544
> >> f0x0 ->state 0x2 cpu 6
> >> [  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g18941
> >> f0x0 ->state 0x2 cpu 6
> >> [..]
> >>
> >> All logs:
> >> http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.=
y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/TR=
EE04/
> >
> > Huh.  Does this happen for you in v6.5 mainline?
> >
> > Both the code under test (full-state polled grace periods) and the
> > rcutorture test code are fairly new, so there is some reason for genera=
l
> > suspicion.  ;-)
>
> Ah. I never saw it on either 6.5 mainline or stable till today. Even on s=
table
> I only ever saw it this once. On mainline I have not seen it yet but I do=
 test
> stable much more since I have been on stable maintenance duty ;-).

I did a couple of long runs and I am not able to reproduce it anymore. :-/

thanks,

 - Joel
