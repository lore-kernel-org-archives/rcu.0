Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C48DC433E6
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 21:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6182333C
	for <rcu@archiver.kernel.org>; Wed,  6 Jan 2021 21:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbhAFVtZ (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 6 Jan 2021 16:49:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbhAFVtZ (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 6 Jan 2021 16:49:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 102D52313C;
        Wed,  6 Jan 2021 21:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1609969724;
        bh=dA2cZ5rOgBp0yWP8pvbxme/WFfTW0pFWk9XusBt5oTE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X/IcOFt9tTt3qkTQSK1N8HJBYOnwuH+USDff2UmwK6Rqta+R8z1IJ2EYkHKT0iZG0
         HWt59F3ssFT/kvFh8jHOTMELINkzy9Vh1OgeCDCZRFae6Bg0yjGXmOPvnFzQ7puwb+
         X2jPQl7J++ckvCICB9mSaZ+XY4/zqaxU2u+3LiDs=
Date:   Wed, 6 Jan 2021 13:48:43 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-mm@kvack.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, ming.lei@redhat.com,
        axboe@kernel.dk, kernel-team@fb.com
Subject: Re: [PATCH v4 sl-b 0/6] Export return addresses etc. for better
 diagnostics
Message-Id: <20210106134843.ed8e298da92d4fe93b6aa259@linux-foundation.org>
In-Reply-To: <20210106011603.GA13180@paulmck-ThinkPad-P72>
References: <20210106011603.GA13180@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, 5 Jan 2021 17:16:03 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> This is v4 of the series the improves diagnostics by providing access
> to additional information including the return addresses, slab names,
> offsets, and sizes collected by the sl*b allocators and by vmalloc().

Looks reasonable.  And not as bloaty as I feared, but it does add ~300
bytes to my allnoconfig build.  Is the CONFIG_ coverage as tight as it
could be?

