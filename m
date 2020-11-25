Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAE7C56202
	for <rcu@archiver.kernel.org>; Wed, 25 Nov 2020 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A09182075A
	for <rcu@archiver.kernel.org>; Wed, 25 Nov 2020 18:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I1ltOa+h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbgKYS50 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 25 Nov 2020 13:57:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729690AbgKYS50 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 25 Nov 2020 13:57:26 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95DFC0613D4;
        Wed, 25 Nov 2020 10:57:25 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s9so3367641ljo.11;
        Wed, 25 Nov 2020 10:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zlxfAmKlZ2meTkcwOhJ+lZFhis5YkbRhTriiiivUvik=;
        b=I1ltOa+hO6lHNKlRNaaWAsY5b1iehbD+I6ukvwUHAM5BdvHcTKEcsNbjHJI9h6icRT
         y6ial1p5Iawr2ZGRsp/hh6xV6TnyhU1aY4efV0ruAW271VLy4BGMSqRGvlxuyTSqa1WX
         DTBcVTw8e7UKxewFn5rthrJhZBDIqMjHL8YWBOf++vEjqHNvvqoYPZsYiL3FWsKgWEfT
         56CrNlEdHjUaVjxlYNgzH6t+6sxLiNlkOLBiZJEQYD93lNVv/cFOx+WpCQrYC3H//aAi
         ZEVInB5NRQT7HBxfja8tHA9JDj88Eee92xykp1sCGG2lF1zfNEWX3b4f2LfyioQZOf0U
         ++pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zlxfAmKlZ2meTkcwOhJ+lZFhis5YkbRhTriiiivUvik=;
        b=UsKcZxIDSxoNqEXFTv4y8CHBw3FAS2vhOOVNRf0p/oca/IACqi85RAJMGajNRaGMoi
         vVViLDHTMx8wG//1BdCyOSv1HTehfH+HaTzOjQBy/mwGwOtkaczzSc25Z0bQamh0H0oC
         L8cyMfP405X1yDfRqF05GY8f9Eog03xZSJPX5OzgT9AvFysIIA5/xmqi1Z/fVqAy/tY0
         aHfGSUCCw7lLDYvzVkkaTiWeNT/uP98lc5KD+Ef7vyKe1ZeN3pcohgBi3UlEKIxmsGxk
         6gRS+CClSyZfocYgvJeN5rlZkD0IzKeM6rBWCz6NTBHya3lSkvwy4ClcqtZ58zT0IvSw
         gHrw==
X-Gm-Message-State: AOAM532NvmRSFYhJZAHs2gHj3ndfireqMBfIZ80vCTpJeDbLT0lC/Lhm
        aezYWWwclNOIlIV6R7Mmm4E=
X-Google-Smtp-Source: ABdhPJxWwU/8e5YM2cNB+Vq6D0eeuTInlNw1FhWsdbANp6dP9ewnF4bwKM9eyqRrW0BYr8ibUPpHew==
X-Received: by 2002:a05:651c:2c8:: with SMTP id f8mr1875888ljo.262.1606330644171;
        Wed, 25 Nov 2020 10:57:24 -0800 (PST)
Received: from pc636 (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id d1sm17542lfs.216.2020.11.25.10.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 10:57:23 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 25 Nov 2020 19:57:21 +0100
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 2/2] rcu: eliminate the __kvfree_rcu() macro
Message-ID: <20201125185721.GA6638@pc636>
References: <20201120114917.5263-1-urezki@gmail.com>
 <20201120114917.5263-2-urezki@gmail.com>
 <20201124195551.GL1437@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124195551.GL1437@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 24, 2020 at 11:55:51AM -0800, Paul E. McKenney wrote:
> On Fri, Nov 20, 2020 at 12:49:17PM +0100, Uladzislau Rezki (Sony) wrote:
> > Make the kvfree_rcu_arg_2() to be open-coded, so readability
> > and review look better from the first glance. Moreover, that
> > makes it clear that both kvfree_rcu_arg_1/2() use one single
> > interface.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> 
> I queued both with the usual editing, thank you!
> 
Thank you, Paul!

--
Vlad Rezki
