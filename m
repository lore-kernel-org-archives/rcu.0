Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018BB3375A6;
	Thu, 21 Aug 2025 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790076; cv=none; b=Vz89P2TdE2t6oVG37VHWBe9dEM7DLl6e4a6AVZWVGkawN5Of4ab2+JfrC74t8f4gmhrRJ5P3MgxwL5St+DPN7geKwxSnq0ROFkIUSrGrkmApjbQlG2PzPcRY6Rf+tWEGAg3ZRF0yXir+YBSG7LWNsgOv2nHmr0rJH5D3BdT16NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790076; c=relaxed/simple;
	bh=SF7RAc04eUcstxwzCz4yCNxN2VF7JhDq7Wf0E9rlY9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7FG/K8wIMXt6nu+MSmaab4As+E7lYRMb+1Rfg8KUkKJljyEu9mnlxKkGvHjrhWZmnQojxuKDfXO8ph3SkKdWqeygk9Oae6pwCVCeSR6gsnl7d9KGJGnDm3PnjU0Ak8Tfudkh0ewYUuS1rjEuf+yL9UYzq1ymp8IrYcIVvpEZyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFNiDMLu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFNiDMLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B898C4CEEB;
	Thu, 21 Aug 2025 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755790075;
	bh=SF7RAc04eUcstxwzCz4yCNxN2VF7JhDq7Wf0E9rlY9s=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=nFNiDMLuNcVTijjupy2BUr4RLgfKzF3bQ4UZO+LIT0i3X04rXuMBlsv9o/8opn1VM
	 +nV4FLvms2BBP/WjVxWNHanTB9Yo/LDxJD4ok9FnnIuBwDYohAd7PbzxC8chbjnQWP
	 XWx24ny41ZkOPdFEMh5r6QgWunZyhz4nqMga2g4lWj0qzKi9Gke5b8LSjVK9jL98Ov
	 lJmDlzsdgPHCtdR6EVYcyMd8wgzxj7O8V3Wru+Ir+MFtEPmGTDRMPgiqg9eW2IkD76
	 Cvfcv97Hrtb4EmaTKa+avQHT2jxGmKrFpC+4aiyaOo4drzMR2W+HluLlnOICaAmL7q
	 uNZ4/adKPDM9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2918ACE0853; Thu, 21 Aug 2025 08:27:55 -0700 (PDT)
Date: Thu, 21 Aug 2025 08:27:55 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	"open list:TORTURE-TEST MODULES" <linux-kernel@vger.kernel.org>,
	"open list:READ-COPY UPDATE (RCU)" <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/2] rcu: Use kcalloc() instead of kzalloc()
Message-ID: <29e4b08e-935c-471c-b802-bdc616ba90d5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20250821134117.6347-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821134117.6347-1-rongqianfeng@vivo.com>

On Thu, Aug 21, 2025 at 09:41:15PM +0800, Qianfeng Rong wrote:
> Replace kzalloc() with kcalloc() in kernel/rcu.  As noted in the kernel
> documentation [1], open-coded multiplication in allocator arguments is
> discouraged because it can lead to integer overflow.
> 
> Use kcalloc() to gain built-in overflow protection, making memory
> allocation safer when calculating allocation size compared to explicit
> multiplication.
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments #1
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Queued for review and testing, thank you!

							Thanx, Paul

> Qianfeng Rong (2):
>   rcutorture: Use kcalloc() instead of kzalloc()
>   refscale: Use kcalloc() instead of kzalloc()
> 
>  kernel/rcu/rcutorture.c | 4 ++--
>  kernel/rcu/refscale.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> -- 
> 2.34.1
> 
