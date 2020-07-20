Return-Path: <SRS0=GZkA=A7=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BCEC433E1
	for <rcu@archiver.kernel.org>; Mon, 20 Jul 2020 14:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC6622482
	for <rcu@archiver.kernel.org>; Mon, 20 Jul 2020 14:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbgGTOlT (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:41:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:54030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTOlT (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 20 Jul 2020 10:41:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA16EB82E;
        Mon, 20 Jul 2020 14:41:23 +0000 (UTC)
Date:   Mon, 20 Jul 2020 07:29:23 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Joel Fernandes <joelaf@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH RFC] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200720142923.mrudcweyttlmnhqp@linux-p48b>
References: <20200719034210.2382053-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200719034210.2382053-1-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, 18 Jul 2020, Joel Fernandes (Google) wrote:

>+/* Move from's segment length to to's segment. */
>+static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
>+{
>+	long len = rcu_segcblist_get_seglen(rsclp, from);
>+
>+	if (!len || from == to)
>+		return;

Nit: You probably wanna do the parameter sanity checks before the
atomic_read.

Thanks,
Davidlohr
