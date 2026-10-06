Received: from heron.birch.relay.mailchannels.net (heron.birch.relay.mailchannels.net [23.83.209.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADED645A284;
	Tue,  6 Oct 2026 13:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.83.209.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791291995; cv=none; b=rdPTQ5C9/50WKMBnIe0YrsZ1UvCg0ZgUB3mIbeazE5W/og1m6zRU1HMeqLiA/3mntNrQiyO/NWaQLLAuLv0BcRfzf7QwEp+zJKGb7rv35AzzKdXyQaHVIL2nNzoBo+pE/psqXqvNwH34eGJ2Z5seDKxbf/kr7ZeBDutxH1u6kFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791291995; c=relaxed/simple;
	bh=9Sged5Y7JLcUfnn6nC5ywnZcDyD/3xZNqddeQggLTY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKIHifSmh2uqsV79ZLP2ms4/O59OnbECoDV8/mPAW8o5ughexQPEaUGCTIsPUtwQFmhgLxAl7HE/iu8oYo07Tim0lEk4u1LR4k0dVxUgpACDMawmoxCKRmXUzZuICA5dJTlW4nWxa4QmfLvqhsXI62G+nHEpM2lCTb2AiNmFsfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=h+IxQpMQ; arc=none smtp.client-ip=23.83.209.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="h+IxQpMQ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id AF2844E274A;
	Tue, 06 Oct 2026 10:42:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a249.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.96.200.220])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 3E0154E2787;
	Tue, 06 Oct 2026 10:41:58 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Unite: 34d0b0920810e084_1791283322547_2811382497
X-MC-Loop-Signature: 1791283322547:1515804786
X-MC-Ingress-Time: 1791283322547
Received: from pdx1-sub0-mail-a249.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.200.220 (trex/8.0.2);
	Tue, 06 Oct 2026 10:42:02 +0000
Received: from offworld (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a249.dreamhost.com (Postfix) with ESMTPSA id 4hzXr53GrFz1041;
	Tue,  6 Oct 2026 03:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1791283318;
	bh=rr5TJWJY6C7KSypPU4bl9ioTNvnD041WlNwnUU65Vpo=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=h+IxQpMQrRjcZ0RaZQZQtxABlkBl3SeFCwzkh6PflJ2l0eaUP6sbNT9dTOIQzGjKG
	 VVODUNyiUTL8parIY6kU4WyfV95WqvygT5uJjZMj6yY0XHFZkRo9w2skGMRF3fO4DI
	 B6MbkMfa/PLZfJMpIbr70nWSpipo4oJ4t1fmclwvwrUPhlsBVCAgvpMgOeINgQklT4
	 VIrk8HViDBYkI8qaasJlISgLna1S3eTgNM/ZPkhRqgXLGzrRgPbCW5iXgmYRVpeifZ
	 w5VXQ9qIrX0gjKOvksE+XUY8Ru2m9B11NXtA49MuX9As9BUfqg0RkpWJURMrgsM19q
	 z20QaU6/aD1mA==
Date: Tue, 6 Oct 2026 03:41:54 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org
Subject: Re: [PATCH] rcuscale: Consolidate per-writer arrays into struct
 writer_state
Message-ID: <20261006104154.xflixj46auqpstff@offworld>
References: <20261005005642.2312272-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261005005642.2312272-1-joelagnelf@nvidia.com>
User-Agent: NeoMutt/20220429

On Sun, 04 Oct 2026, Joel Fernandes wrote:

>The writer kthreads keep their state in five parallel arrays indexed by
>writer number: writer_tasks, writer_durations, writer_n_durations,
>writer_done and writer_freelists.  Each must be allocated, NULL-checked,
>freed and cleared separately, and the cleanup path needs several
>guards to cope with any one of them being missing.
>
>Collapse them into a single array of struct writer_state, holding the
>task pointer, the duration buffer, the measurement count, the done flag
>and the existing struct writer_freelist.
>
>This reduces initialization to one allocation and one out-of-memory
>check, and cleanup to a single kfree().  As a side effect, this also
>fixes a leak: cleanup only ran its frees under "if (writer_tasks)", so
>if the writer_tasks allocation failed while a later allocation (for
>example writer_durations or writer_n_durations) still succeeded, those
>already-allocated arrays were never freed.  With a single allocation,
>that partial-allocation state can no longer occur.
>
>Assisted-by: Codex
>Fixes: 8704baab9bc8 ("rcutorture: Add RCU grace-period performance tests")
>Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
