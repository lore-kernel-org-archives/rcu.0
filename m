Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCE1E22FC;
	Mon,  7 Jul 2025 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751898131; cv=none; b=AUnkjAIa9qhNIdcTd3qxAg9FaeF06v1dQlm2pDlVa3i4KqrKvbhO0Mr1Ng7Qnl41oxYFDt6kWtuFm6KH0MYxDgRz/Oxo+pHZNanbwOTrmj4mOs+6TJTAoKHxkkALHYRakvgd5ulzuRmSHu5ZZJ3vUCMMkJ8IPF4af/1ptLTnx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751898131; c=relaxed/simple;
	bh=W7q8C3xrheSK5UsfA8zsgl5RRMzThIjledkWEDgN8pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3AA3+qQyTfeGCGv9VeTnwAvgDpjfO3l3J8tYJQGKn1G0uj/dFM5XIZWmH2AlvPDsqqZq5mNjVC+qppr+ctyFmXo7ud2Hc+eDwVP7gtybbKvGGbLNhe53vgCcM+NryysPqvgzYNQozUY9TZELZWtoDE5MOmMaEPtTVdZUU/NhU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cf2xA0ir; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cf2xA0ir"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB53DC4CEE3;
	Mon,  7 Jul 2025 14:22:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751898131;
	bh=W7q8C3xrheSK5UsfA8zsgl5RRMzThIjledkWEDgN8pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cf2xA0irTVr7hr55mxRzLPweFG20hXbtXrAmidteADVg4vZcQwYxGJFjFwWOO1amS
	 OlZvjd0a5YDvCheqcftIpQh+d7KAM87m55SSqCzvqwuQx4U1zPnzIoNQhIsxRi/iMV
	 kqySdl35naZhUkA30JTWsCSb9NHC3EwGpOKrHUBeLwrIwnKyS1WImmM+8krKeDSe0C
	 xjZysR/6g4J/1sIr3AG6HveeF2g/gqtomqIV4Wgmn89++bqW8zBoPxlHlb/9Vt7l6r
	 gUKj5ifUdH/zTfvePKvaytNEswV/DF8AG8vM9q94EBmO8yAn3hSCDoaIRTWcYMBCkI
	 6ZhBE4UuUBtdA==
Date: Mon, 7 Jul 2025 16:22:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Jonathan Corbet <corbet@lwn.net>,
	rcu@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] rcu: Document concurrent quiescent state reporting for
 offline CPUs
Message-ID: <aGvYEFikpNdX-lGE@localhost.localdomain>
References: <20250707033208.361677-1-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250707033208.361677-1-joelagnelf@nvidia.com>

Le Sun, Jul 06, 2025 at 11:32:08PM -0400, Joel Fernandes a écrit :
> The synchronization of CPU offlining with GP initialization is confusing
> to put it mildly (rightfully so as the issue it deals with is complex).
> Recent discussions brought up a question -- what prevents the
> rcu_implicit_dyntick_qs() from warning about QS reports for offline
> CPUs (missing QS reports for offline CPUs causing indefinite hangs).
> 
> QS reporting for now-offline CPUs should only happen from:
> - gp_init()
> - rcutree_cpu_report_dead()
> 
> Add some documentation on this and refer to it from comments in the code
> explaining how QS reporting is not missed when these functions are
> concurrently running.
> 
> I referred heavily to this post [1] about the need for the ofl_lock.
> [1] https://lore.kernel.org/all/20180924164443.GF4222@linux.ibm.com/
> 
> [ Applied paulmck feedback on moving documentation to Requirements.rst ]
> 
> Link: https://lore.kernel.org/all/01b4d228-9416-43f8-a62e-124b92e8741a@paulmck-laptop/
> Co-developed-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Very nice and welcome!!!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
