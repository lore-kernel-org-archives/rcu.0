Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7E7C2D0A3
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA869223C6
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 14:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604414847;
	bh=62SPvuFatUemwtljHtmpCrMGumTbi+10rgi7iVjyUEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dVHZRoohA+/+r6+Wd8BF3slksOH2IRFst+y3NRj22glEAV+qQuZh9oYgaHAbdVk4e
	 KLzO125yzkTaLZzVFXOVx0XV78gBEC7RcYdCq6xOG+JkPvRoBbQZGpRJzUT0ohXoti
	 H2pbN1Wpkd+Y1+HID11WKTdtHsL1xY81v25S1YcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgKCOrW (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 09:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbgKCOrS (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 09:47:18 -0500
Received: from localhost (unknown [176.167.46.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E79F922370;
        Tue,  3 Nov 2020 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604414837;
        bh=62SPvuFatUemwtljHtmpCrMGumTbi+10rgi7iVjyUEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BsL9/V26ECzEN+QHQ7nXC2aCU4nLrGVjUSriAuEIpCGz+QK+kGaRXlGpIF0zsP0V0
         +9jBxbqGXcN4ufAJ4CzCCI/QnsCRnNxl2oxGCxQtGewFIWDvjLdy1THto1ZqxmXJv3
         5Rx0f6UdDJCm/ZPZ/a5Yvm4Ol8LQJcIhP7334tEk=
Date:   Tue, 3 Nov 2020 15:47:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 3/7] srcu: Fix invoke_rcu_callbacks() segcb length
 adjustment
Message-ID: <20201103144714.GA432431@lothringen>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-4-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103142603.1302207-4-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 09:25:59AM -0500, Joel Fernandes (Google) wrote:
> With earlier patches, the negative counting of the unsegmented list
> cannot be used to adjust the segmented one. To fix this, sample the
> unsegmented length in advance, and use it after CB execution to adjust
> the segmented list's length.
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

This breaks bisection, you need to either fix up the previous patch
by adding this diff inside or better yet: expand what you did
in "rcu/tree: Make rcu_do_batch count how many callbacks were executed"
to also handle srcu before introducing the segcb count.

Thanks.
