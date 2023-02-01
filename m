Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3E2C636D4
	for <rcu@archiver.kernel.org>; Wed,  1 Feb 2023 10:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjBAKZj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjBAKZb (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 1 Feb 2023 05:25:31 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7509A4589A
        for <rcu@vger.kernel.org>; Wed,  1 Feb 2023 02:25:27 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id u18so10212456qvv.9
        for <rcu@vger.kernel.org>; Wed, 01 Feb 2023 02:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNeTW24ZRW/uaf23mE98U6Vb2AlvUvFrAAGQ/YbFVds=;
        b=wyLERRlh5lHBfHS6DLBdU73BwiilL3MLW7Ks2sdu5hxUSaE9gJ+euyp9tucK8bXx67
         +sEFWF82bDI0Ags1eANZjTvZzrhDJYH/+IkDSzTmBzrgGQ+4eSL6+4kxXOrMZiI2GBSH
         i3m29eBynLsMmKq4bEIpzcTbT4KgmVJolLhe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNeTW24ZRW/uaf23mE98U6Vb2AlvUvFrAAGQ/YbFVds=;
        b=Gu6/ruhPvQRH9FagPWDHL1D9XS49ZSctH3z2pmj7fpxlX1Vxc7hsOln9xevaa9BK3H
         ShguJF8IQ3t6gWSTMqfzIzIem1bENfGFHe8VnqgWg0OBKzrru8CuDNXkynTYcse4WsCh
         6mt3HyBiMHQzvY/h/oyY5dWPQxDaurQ0njEStEgl6Fl8dNFADvLgt8IJ+xXtU9iwAPAb
         Gk4A/95HaO30oPIErdLY0X7dqRhnQ293A35uwlm/Wer0wxU3Ryyde7pQl0uDWgcugt9R
         HUizMrev/dpnPfc1UKFn/LLp66WYYMES8WbocoDYjYSSMjbIqDeEHGSDYw/vC2rwu9/+
         kdnw==
X-Gm-Message-State: AO0yUKVZgfUZQNBfQmpj1O60Dfa/zwg7pJhBJ6wzvm0rs0jdigickvCg
        UGh+6kE4v0YFDKTpAjCgCbwUaQ==
X-Google-Smtp-Source: AK7set81aZRR1SHl84Eyz6Jaj+5OUd8o8MPIigiPFBG8LROIt3RXyoknCWO62VVtYeuVgffJtk/Few==
X-Received: by 2002:a0c:cdc3:0:b0:537:7181:c903 with SMTP id a3-20020a0ccdc3000000b005377181c903mr2880285qvn.34.1675247126319;
        Wed, 01 Feb 2023 02:25:26 -0800 (PST)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id o2-20020a05620a110200b0071bfeaf5688sm7734578qkk.72.2023.02.01.02.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 02:25:25 -0800 (PST)
Date:   Wed, 1 Feb 2023 10:25:25 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     lsf-pc@lists.linux-foundation.org
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-mm <linux-mm@kvack.org>, rcu <rcu@vger.kernel.org>
Subject: LSFMMBPF proposal [MM]: Lazy RCU memory reclaim
Message-ID: <Y9o+FWwoLUdp2ees@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Title: Lazy RCU memory reclaim: Design, mainlining and next steps

Description:
Lazy RCU is a new technique introducing multi-second delays in RCU memory
reclaim, done to save power on Android and ChromeOS.

This talk is to describe the internals of how this works, and issues
encountered. We will also discuss the mainlining of the patches, and future
work. It is desired to also garner more interest in the -mm community and
spread awareness of this work, including future work:

 * Delaying reclaim for other flavors of RCU (such as SRCU).

 * Possible integration of delayed free'ing into the slab (FreeBSD does this
   for their equivalent of RCU, for instance).

 * Development of tooling to monitor RCU activity (BPF or otherwise).

 * Any positive or negative effects on usecases we should know about (per-VMA
   locks, BPF etc).


thanks,

 - Joel

