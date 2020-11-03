Return-Path: <SRS0=6i3J=EJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3803C388F9
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6766A20735
	for <rcu@archiver.kernel.org>; Tue,  3 Nov 2020 15:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604416676;
	bh=9opHv5HlVWY9WINb/wi84zKIE/BZCwANE5Afuxrhksw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jTWYm2YKco4pS07xP9GKrHZspNa2RmcIaWxrsNIXVh58ysO3IbZt38hAaZUHKV/wc
	 +635WE4rhEcuQoJ0H5cJ1pHsubhyfFE/Qdx6igkFxcLoWkmnoT5+AVm/siT+LoWVsr
	 0NQ/5TIaozGIVon6N81ZjGCoGJ9Xjw80UxUS8oPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbgKCPRx (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:17:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:58914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728536AbgKCPRk (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 3 Nov 2020 10:17:40 -0500
Received: from localhost (unknown [176.167.46.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B7C20780;
        Tue,  3 Nov 2020 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416654;
        bh=9opHv5HlVWY9WINb/wi84zKIE/BZCwANE5Afuxrhksw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n/bOFh/ZZazf76HM8I0koE69xr5tuhgNBHlVkxOiwKuhZfgYzqdXFzPSepFUvSwa3
         SF4JDlQWp1ddoc1YMJfEyvpigXEvTHkRsVKEfQZWQlrtYD411hldeOALos8fiB7cji
         exIPe4x7xHELFeJvbmQlecGYdc1TA8m03KI8s/o4=
Date:   Tue, 3 Nov 2020 16:17:31 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, fweisbec@gmail.com,
        neeraj.iitr10@gmail.com
Subject: Re: [PATCH v9 4/7] rcu/trace: Add tracing for how segcb list changes
Message-ID: <20201103151731.GB432431@lothringen>
References: <20201103142603.1302207-1-joel@joelfernandes.org>
 <20201103142603.1302207-5-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103142603.1302207-5-joel@joelfernandes.org>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Tue, Nov 03, 2020 at 09:26:00AM -0500, Joel Fernandes (Google) wrote:
> +/*
> + * Return how many CBs each segment along with their gp_seq values.
> + *
> + * This function is O(N) where N is the number of segments. Only used from
> + * tracing code which is usually disabled in production.
> + */
> +#ifdef CONFIG_RCU_TRACE
> +static void rcu_segcblist_countseq(struct rcu_segcblist *rsclp,
> +			 int cbcount[RCU_CBLIST_NSEGS],
> +			 unsigned long gpseq[RCU_CBLIST_NSEGS])
> +{
> +	int i;
> +
> +	for (i = 0; i < RCU_CBLIST_NSEGS; i++) {
> +		cbcount[i] = rcu_segcblist_get_seglen(rsclp, i);
> +		gpseq[i] = rsclp->gp_seq[i];
> +	}
> +}
> +
> +void __trace_rcu_segcb_stats(struct rcu_segcblist *rsclp, const char *context)
> +{
> +	int cbs[RCU_CBLIST_NSEGS];
> +	unsigned long gps[RCU_CBLIST_NSEGS];
> +
> +	if (!trace_rcu_segcb_stats_enabled())
> +		return;

Yes, very good!

Paul just told me that RCU_TRACE can be used in production so that confirms that we
wanted to avoid this loop of 8 iterations when tracing is disabled.

Thanks.
