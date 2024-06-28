Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71825481B8;
	Fri, 28 Jun 2024 20:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719604988; cv=none; b=oITHXbHjIQfExreNmYxjnxs/qEdhoPZ+k0DWGj+NllE20fVGtQLQQ5nFy+hsUMONY92UYRaViVxaqX1o9oK3aBCPX8nrxMKyYtCF4P4B9EoLZaEF8rel3U1AeWbKOS3SWcqF543i9gs1FkpkHBmm6VHu+hT1cIvIMnYl7rOMU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719604988; c=relaxed/simple;
	bh=d3/GdaUlUJlYoTg6fp9s+deg5+BDjAmeYQ3kcgmalTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=osSH0AdNlC8OUtS2iRJEP/7TQwv+W/DhNPXfse8ByZJDXYs0mcfoeHOkCWgeg17opAyGT8pDW21FqFjd/WRplG2JJyx0u2KODSKgzWfn/YhUOcsnGitNnzMo7zxuOvVuxscVLbko+GA59alJ71xCUMkxQo5EnxwevOvJjTG9Ppk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG5fO1wB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG5fO1wB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD069C116B1;
	Fri, 28 Jun 2024 20:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719604987;
	bh=d3/GdaUlUJlYoTg6fp9s+deg5+BDjAmeYQ3kcgmalTI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lG5fO1wBgkbdc0YhTnp5VQqCK8urawwrcUpUv5EcJzsqXuw4Pqp2bZnHZuj4jvVh3
	 M6f8MLuiVRkJtbUJ44bmKf8tDx5JkqM4hcxFrRNtKjqTOmF9Fek3T3l3GkZe15ETLl
	 EdX3Dwfb6d3vNn+AAxqvHOkmegLVooYTPC0AJWW5Q6+1eFTPyQSlbGsvRncbLzd7N0
	 ThIAKkT1bXG4WiPc8kU3YhNEcamURNjpR4IrfiV/fM4WzXCION7G2Wc7NN7pFnr6Db
	 JadbPl+XcuLvzP/dDV4E9SGy0t1Ak//Ypq9U2aX9BuTDz5/gp1QqEb83pAs+kayT3N
	 WLkLJpXMUiBoA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AA632CE088B; Fri, 28 Jun 2024 13:03:06 -0700 (PDT)
Date: Fri, 28 Jun 2024 13:03:06 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org
Subject: Re: [PATCH rcu 3/6 v2] rcu/exp: Remove superfluous full memory
 barrier upon first EQS snapshot
Message-ID: <22e77bf0-9af3-4ed1-b0c9-768ae5c06620@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <81f4e616-8125-4934-a8e2-fd5beae90995@paulmck-laptop>
 <20240604222652.2370998-3-paulmck@kernel.org>
 <Zn1O2qKaIVOXniYH@pavilion.home>
 <4a11271a-d873-4f1c-87e6-38874e38ac13@paulmck-laptop>
 <Zn6cl8PJWd8hWS_R@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zn6cl8PJWd8hWS_R@localhost.localdomain>

On Fri, Jun 28, 2024 at 01:20:55PM +0200, Frederic Weisbecker wrote:
> Le Thu, Jun 27, 2024 at 11:53:29AM -0700, Paul E. McKenney a écrit :
> > On Thu, Jun 27, 2024 at 01:36:58PM +0200, Frederic Weisbecker wrote:
> > > When the grace period kthread checks the extended quiescent state
> > > counter of a CPU, full ordering is necessary to ensure that either:
> > 
> > Just to make sure that I understand...
> > 
> > I need to replace these commits in -rcu:
> > 
> > da979d0162fc6 rcu: Remove full ordering on second EQS snapshot
> > 6411f4185f657 rcu: Remove superfluous full memory barrier upon first EQS snapshot
> > dec56ca5f1c34 rcu/exp: Remove superfluous full memory barrier upon first EQS snapshot
> > 
> > With these three patches, and keep these three commits as they are?
> > 
> > d43a302fc08a5 rcu: Remove full memory barrier on boot time eqs sanity check
> > b1c36aa90cbf1 rcu: Remove full memory barrier on RCU stall printout
> > 64d68f1d53f77 rcu/exp: Remove redundant full memory barrier at the end of GP
> 
> Exactly! Those were the precisions I forgot to mention.

Done, and started testing.  If all goes well, this might make tomorrow's
-next.

							Thanx, Paul
