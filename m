Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA46C433EF
	for <rcu@archiver.kernel.org>; Wed, 24 Nov 2021 14:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbhKXPCR (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 24 Nov 2021 10:02:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:35168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234545AbhKXPCR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 24 Nov 2021 10:02:17 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29E1B60C3F;
        Wed, 24 Nov 2021 14:59:06 +0000 (UTC)
Date:   Wed, 24 Nov 2021 09:59:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 5/9] x86/mm: Switch to kvfree_rcu() API
Message-ID: <20211124095904.3eefc63c@gandalf.local.home>
In-Reply-To: <20211124095803.2702bc89@gandalf.local.home>
References: <20211124110308.2053-1-urezki@gmail.com>
        <20211124110308.2053-6-urezki@gmail.com>
        <20211124095803.2702bc89@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Wed, 24 Nov 2021 09:58:03 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Other than that, the patch looks fine to me.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

This was suppose to be for patch 9/9:

  [PATCH 9/9] tracing: Switch to kvfree_rcu() API

I replied to the wrong patch.

-- Steve
