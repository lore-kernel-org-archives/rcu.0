Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4248BEC8738
	for <rcu@archiver.kernel.org>; Thu,  7 Sep 2023 16:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbjIGQR1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbjIGQQ7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Thu, 7 Sep 2023 12:16:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2301526AF
        for <rcu@vger.kernel.org>; Thu,  7 Sep 2023 09:07:23 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-68e4700c931so300683b3a.3
        for <rcu@vger.kernel.org>; Thu, 07 Sep 2023 09:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694102777; x=1694707577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r6n7B65MZY+NEYtpII6NMfxvbqb6oukije8HHCi5Tx8=;
        b=l+WiKDfGJA4hnd7yT1ejuglXLh29fFKApE0aUoa6cypppxwJX31V96hXaRQPWKp9h4
         faPBW7Q+nZvhUp/0YsUmORC5QsbVRN+jQpP5dLBfVWQLoNDB/2PLoznhmH/lGq8SuOKY
         ezfQ95nqRp+Dm+i+zClEOeyy9qNyxSeRd31WvMbMoeo6bjCd74pzgqzZ4kQkfv3URP/t
         ZT9qid6vpNCwAMZ2uHVWTTLkLL/Jg8E8eStFHVhdZ6ZWx0dXdwsN5g+Uc3duLiFJ+C39
         ql0bzFJMSOFr8J3aeHjfw1z9J9I+80FJc6fi4Om62yMpv7goiTEvWLWLRMrM24uagfg0
         Yg6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694102777; x=1694707577;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r6n7B65MZY+NEYtpII6NMfxvbqb6oukije8HHCi5Tx8=;
        b=GKjvZBV3gyRg7gVeWBFk/w0vnvxIGbtQqAuGlFeggVaD6OBy0rlL6RNFVHcciTD8jI
         PF5vHI0DvegNU7OWyKWgzbLrqV37NhQV2+w0uq4bZ1Kh6h+obYKdnuzorU0/zQNF8gHr
         TSD/rKJaksGEY/fTzliWe0lD8PEuo3ApW85Ldz4Lzx9ZMuzxXE03S6LfknKE1ERhtkQO
         lNx4JvP8l2hCaHltNT5t2g+YyLX3S7D609bq7u5A44AcmpxhI5wTOGtFYky+mNX3hcWu
         EVrl/dJ5EEIO3Jtox4TEJsBdHMMoxstZCAzB4k7MHZiZO4pqmuqPf9HilmIr/CK7gGmj
         3+iw==
X-Gm-Message-State: AOJu0Yy+cx/nlc4IAWVabC042GwUKryUoeRfYYC+6Dfbj8d27NeM03eM
        wEFgxwgpvb9ibDpBZ+GFKRpHx+y4A12CMaPkTG3PueQr1h1fmYFIcyMRjPvt
X-Google-Smtp-Source: AGHT+IEOWnsZ9JeUOEbgfkdxUiQXF+Lys1hlRY83rq3C5ypKQ1H/IIZFLywETHMuDzO+NBLqPhnJGwU9tC5UCR7P3Ds=
X-Received: by 2002:a17:90a:5785:b0:263:f435:ef2d with SMTP id
 g5-20020a17090a578500b00263f435ef2dmr14982611pji.10.1694092646138; Thu, 07
 Sep 2023 06:17:26 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Fernandes <joelaf@google.com>
Date:   Thu, 7 Sep 2023 09:17:15 -0400
Message-ID: <CAJWu+ooLBjAhZbHa+64egmh53-n7qc_o+PvsfSt2hzQNrVhdqw@mail.gmail.com>
Subject: [BUG] TREE04 hang on 6.5.y stable: Writer stall state RTWS_COND_SYNC_FULL
To:     rcu@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,
Just started seeing this on 6.5 stable. It is new and first occurrence:

TREE04 no success message, 234 successful version messages
 [033mWARNING:  [mTREE04 GP HANG at 14 torture stat 2
[   38.371120] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g1253
f0x0 ->state 0x2 cpu 6
[   38.388342] Call Trace:
[   53.741039] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g3637
f0x2 ->state 0x2 cpu 6
[   69.093462] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g5501
f0x0 ->state 0x2 cpu 6
[   84.450028] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g10505
f0x0 ->state 0x2 cpu 6
[   99.815871] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g13781
f0x0 ->state 0x2 cpu 6
[  115.166476] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g16544
f0x0 ->state 0x2 cpu 6
[  130.550116] ??? Writer stall state RTWS_COND_SYNC_FULL(10) g18941
f0x0 ->state 0x2 cpu 6
[..]

All logs:
http://box.joelfernandes.org:9080/job/rcutorture_stable/job/linux-6.5.y/17/artifact/tools/testing/selftests/rcutorture/res/2023.09.07-04.10.25/TREE04/

thanks,

 - Joel
