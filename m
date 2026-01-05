Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37D275AF5;
	Mon,  5 Jan 2026 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767627096; cv=none; b=q3Znce0t2XjMWd6MkGaDzMeXS1qGyo9duQEppt89HBkfcNIeoHd/wDL4h7tkk42GXQhSYaZ1l6Hn1KPGJsfPHYrPGt9ShPxUxExmDeA3CsJM7qqm6DaIlpZNK2xOjokbSTlMbf+xKghTN338vrs/OEur84WtczYN8nuc2anyy88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767627096; c=relaxed/simple;
	bh=fhbS21r0DEYIF4aR+XvrROnenWGn+ZEo2jFpNN4D15s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRW6INyZqlKe6GOtXonMq3rHzOFkwBZWJVcDiq1HLzXAOrzqGR0Esgm/Tn+XR9tDdc4aPAPORWSl7WabYoFVLj86Pl4vQMOefZPy9k6P/2HwBwfXo+iLfz4aqCXivmliViAuH4DYCmgQOEtrv6FDGVKaEQ5Hzr0JE4fyyD6b0rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id CE720B661A;
	Mon,  5 Jan 2026 15:31:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 1AFA630;
	Mon,  5 Jan 2026 15:31:23 +0000 (UTC)
Date: Mon, 5 Jan 2026 10:31:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E . McKenney" <paulmck@kernel.org>,
 Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Josh Triplett <josh@joshtriplett.org>, Boqun
 Feng <boqun.feng@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Zqiang <qiang.zhang@linux.dev>, Uladzislau Rezki <urezki@gmail.com>,
 joel@joelfernandes.org, rcu@vger.kernel.org
Subject: Re: [PATCH RFC 01/14] rcu: Add WARN_ON_ONCE for blocked flag
 invariant in exit_rcu()
Message-ID: <20260105103145.5b3eaaf5@gandalf.local.home>
In-Reply-To: <20260103002343.6599-2-joelagnelf@nvidia.com>
References: <20260103002343.6599-1-joelagnelf@nvidia.com>
	<20260103002343.6599-2-joelagnelf@nvidia.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1AFA630
X-Stat-Signature: 8c9djftkjbouqo131ctw7h5hgccj3qn5
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Qy7KqdzUBPUoxr6Yu1sldc6piq+CDu0g=
X-HE-Tag: 1767627083-56495
X-HE-Meta: U2FsdGVkX1/CMwVPDyPftzUIYBbvh4MYuTuRcK/jpkNkUUEavkCE/eoXfgpS6lybvaCGAlaD72wzQX4SXw83NT+o+BFMM/dJS8NKmoZ9DwF9ejOVGtq82VyzBuynDZyconYeJst4RFQ4Xt4uEACQfZ4M9AxFT/x6kZ2Gzaw2sPcJONdSFsckyZx/6uBdPGU2epza0nfum8JJv3DwflzujhESe9q1JpZn0/nAUTKdm8REpMXpQjYZPJUTWiWRtfp2UCUP3rquZGMkgBPu+VGCweozu/8GoguK9cj6bVFQgOMev6Dk71u3iWHtaL0SRMl1KCurJErOFpuEWQbeKkfqDtKPXBEQ09l2

On Fri,  2 Jan 2026 19:23:30 -0500
Joel Fernandes <joelagnelf@nvidia.com> wrote:

> Add a WARN_ON_ONCE to detect this invariant violation. If this
> warning ever fires, it indicates a bug where a task was added to
> a blocked list without properly setting the blocked flag first.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  kernel/rcu/tree_plugin.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index dbe2d02be824..73ba5f4a968d 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -846,6 +846,7 @@ void exit_rcu(void)
>  	if (unlikely(!list_empty(&current->rcu_node_entry))) {
>  		rcu_preempt_depth_set(1);
>  		barrier();
> +		WARN_ON_ONCE(!t->rcu_read_unlock_special.b.blocked);
>  		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);

If we warn when it is not set, could we just remove setting it?
Or do:

		if (WARN_ON_ONCE(!t->rcu_read_unlock_special.b.blocked))
	 		WRITE_ONCE(t->rcu_read_unlock_special.b.blocked, true);

-- Steve


>  	} else if (unlikely(rcu_preempt_depth())) {
>  		rcu_preempt_depth_set(1);
> -- 
