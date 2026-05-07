Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10BDC2E54BD;
	Thu,  7 May 2026 17:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778176431; cv=none; b=oklArHJjnnRERvU+rMiy/jRa4+Eoz5q+jQl+u01QNzYOApl34ZbdTuCqFU631UEYhOHlOYdFXxnJRPEAF+nn028s1pPsRFWgvXKVE3ns3yYjBcgSL0LyWUTzXWJ7JrqPq/bBEUrWBJvMVzoVPKHHRUGcmuK6NPR7ChIWa4TazRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778176431; c=relaxed/simple;
	bh=p/zLbG4h0i7mdl9B5PY/Ouz1XL0LsYpug/qvBEATz7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZupWdByo+IfPyPeGI2q4jPIZY1zgNqwGqZ8BRQBdoptdqaFnLV1lVyg1QsHeQGEwIaHyk1xi/4PPZcqYekzhjGNkzy5TBHwDONswxgNc9hpc4+ZkZ6NaDgSzAzpNsyi0AGp0HcUyyR4z67boXChKscqQ9bZ+7o7Ad5t+h3H6ggQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S7S6pCXu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7S6pCXu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A367EC2BCB2;
	Thu,  7 May 2026 17:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778176430;
	bh=p/zLbG4h0i7mdl9B5PY/Ouz1XL0LsYpug/qvBEATz7w=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=S7S6pCXuUk6Mce4OlWwUvQOWEjrOKvcuMU2iQWXgu94973LXy6D6rtUEddEOOMLB7
	 6EXw9HTCFGDoutfZQTWb6kulGBrE5OaJuojNzTFsguKBG2SppxVxvVt9El/GEdQ++M
	 2XmmwyDwTBXjajXO+CYq3lEclxNSBP8gdauQr2+0ulBwKeT+KcIpfE380IC9LuvC2I
	 FhPYUnimmONrSt+/l7uEm0NpgKl8Pw46df4QkdobO1t3i3DlulQPJBLdPvEJV4U3qY
	 KTJVHxBaOtHLImnyPl6iTwZDZyK4XCZ1Ib8+NdEMEGf0GrHIQFuIEC1NgPieEe/62C
	 mPCETihKPC64g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 48F0ECE0863; Thu,  7 May 2026 10:53:50 -0700 (PDT)
Date: Thu, 7 May 2026 10:53:50 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org, Puranjay Mohan <puranjay@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH 3/7] checkpatch: Undeprecate rcu_read_lock_trace() and
 rcu_read_unlock_trace()
Message-ID: <0db70a0b-cd88-4a03-bbb4-a765ffe12aa2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <eeeda48e-03ed-428a-847d-5a0b56508b68@paulmck-laptop>
 <20260507170950.2040199-3-paulmck@kernel.org>
 <38a4724712f8bda29fae9d9d838dfe27eb1edb7a.camel@perches.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <38a4724712f8bda29fae9d9d838dfe27eb1edb7a.camel@perches.com>

On Thu, May 07, 2026 at 10:44:39AM -0700, Joe Perches wrote:
> On Thu, 2026-05-07 at 10:09 -0700, Paul E. McKenney wrote:
> > It turns out that there are BPF use cases that rely on nesting RCU
> > Tasks Trace readers.  These use cases are well-served by the old
> > rcu_read_lock_trace() and rcu_read_unlock_trace() functions that maintain
> > a nesting counter in the task_struct structure.  But these use cases incur
> > a performance penalty when using the shiny new rcu_read_lock_tasks_trace()
> > and rcu_read_unlock_tasks_trace() functions, which nest in the same way
> > that SRCU does.
> > 
> > This means that rcu_read_lock_trace() and rcu_read_unlock_trace()
> > will be with us for some time.  Therefore, remove the checkpatch.pl
> > deprecation.
> 
> Fine by me.
> Perhaps combining patches 3 and 4 would be more intelligible.

Very good, I will merge them on my next rebase.

							Thanx, Paul
