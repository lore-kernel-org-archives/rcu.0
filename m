Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484FFCD37B0
	for <rcu@archiver.kernel.org>; Sat, 16 Sep 2023 01:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234025AbjIPBJz (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Sep 2023 21:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238754AbjIPBJy (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Sep 2023 21:09:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB49C90
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 18:09:49 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-77ac14ff51bso90868639f.3
        for <rcu@vger.kernel.org>; Fri, 15 Sep 2023 18:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694826589; x=1695431389; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i998LrKgT5WkKeIreABdS/VCP6RWwlCIyAuUDhjqdBI=;
        b=Zgcw0D//mEezDRF7KOGYuk/ZbB3yH8u4g3SsqWc9aZlMKNPfGH+FW+bks9zSeyJfm3
         QjXb8oWqkd9LXQutucuRdpi/WX+RR0wUs9NjZ5i6Q/wlYDV9bwKXWlsarZO2YxICVSwO
         5DOSnG+NvNb9ytaxLC97njWEzVq9eUnPd+EQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694826589; x=1695431389;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i998LrKgT5WkKeIreABdS/VCP6RWwlCIyAuUDhjqdBI=;
        b=P4j1GqDVbn5nMzpna//08JBe8idFEBIX2aJkun/Ua3d4AUjjOlAZQsnMMa3eeXFTEJ
         cqDdDyFkHqb8KwVfLGifLIBg1K43zo1nHyUxTBLrJ5BA9cXQOaBbd/PtJo11goUmpOtT
         s54FzT2L5HDWSiqrUWOvvsR3QZ2xkWqL7SMGzj6xrL9yOleghut1v8Em2ZQwZ6QDgWJG
         BgXQhbEYXMLmzFU55LIySgvhs5TUFKY+8D2fdTNlv1rz1OSwBe/Wrswe5e9kBJUFqWMc
         XR77wa5ct7Bna41Bdr/Og1Kpz7ZP1s9WZEks4QwCJSzd4Bm+jw3c6Zp1DlZ6hvdbY4xQ
         4l/A==
X-Gm-Message-State: AOJu0YzU/kz+UBTy3awYirIeNImBRueiqe0cR/ZGgceyk/O0Saj84B2s
        2IrphAqIblNL8Q91z3A4uypEoieSn+KgPPXo9hc=
X-Google-Smtp-Source: AGHT+IE1+NCBodGv19w5j2vygY4IP+WY21ziS2emWQDctr256vPMNFJ46RbzMzEZ+qjMLNacHtSO5g==
X-Received: by 2002:a5d:9ac4:0:b0:786:f4a0:d37e with SMTP id x4-20020a5d9ac4000000b00786f4a0d37emr3986062ion.4.1694826589040;
        Fri, 15 Sep 2023 18:09:49 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id m15-20020a02c88f000000b0042b05586c52sm1422854jao.25.2023.09.15.18.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 18:09:48 -0700 (PDT)
Date:   Sat, 16 Sep 2023 01:09:48 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org
Subject: Re: [BUG] TREE04 hang on 6.5.y stable: Writer stall state
 RTWS_COND_SYNC_FULL
Message-ID: <20230916010948.GA60414@google.com>
References: <CAJWu+ooLBjAhZbHa+64egmh53-n7qc_o+PvsfSt2hzQNrVhdqw@mail.gmail.com>
 <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208d035b-a411-40d0-bb5e-59deb6a785e6@paulmck-laptop>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Thu, Sep 07, 2023 at 07:34:44AM -0700, Paul E. McKenney wrote:
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
> > http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/TREE04/
> 
> Huh.  Does this happen for you in v6.5 mainline?
> 
> Both the code under test (full-state polled grace periods) and the
> rcutorture test code are fairly new, so there is some reason for general
> suspicion.  ;-)

I happened to hit this again but this time on 6.1 stable and TREE05:

Here are some logs:
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.1.y/139/artifact/tools/testing/selftests/rcutorture/res/2023.09.15-04.02.48/TREE05/

I am planning to look closer soon. thanks,

 - Joel

