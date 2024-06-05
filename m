Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539FC152;
	Wed,  5 Jun 2024 18:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717612216; cv=none; b=HyKSkTfI9ic3C+y9NXD30D1PE5UfyxU7ge91I8LYDWZFIQGcsdSeEQ2IG4YzjVpnptxk0IgpAY4nOduX9qPwEHDpHhGf2n3T1EJ+KIfeGYCv1Sla1BbfuWBt20PARFHe24J1zgAfi9WsIrjBeqwunyOICL4HeOizrYTiM8kQJDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717612216; c=relaxed/simple;
	bh=f6+Zmqaj9wYQgHnyuXr46oqal24ofdFPyIBCkDLn3Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6RpTS6HA21jyBhVxcneVXq5FgSw3ogDKUC2vm9ey3VZOo3vQ4L8U4AMC9t7eMs1Z4qckLxFsETXXBP9AapMP3UjMlT8MqgzG6jUmW7DBjGQFiRetTeMYhNTftwGWNRQ3389NNENurEBbw8cF277jEybPfOe1Zi/31w8cVtZbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dga7u/K4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dga7u/K4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA120C2BD11;
	Wed,  5 Jun 2024 18:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717612216;
	bh=f6+Zmqaj9wYQgHnyuXr46oqal24ofdFPyIBCkDLn3Dw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=dga7u/K4Y//JS1Fmd7gzq/Znn/OCiCYOre5bBR51okMPpcVU7QedW0AmMnVgiCUfG
	 YoPJNF53PfXkEIiwglETP31n/DhuT7W80u3/KuZaWRQm7vElYfJiD6ZH+VxbKNOkWh
	 yzlxKmirjythbpT7UXfSZtTCJZ9LAVgRngcawA6SCcF6QFFv3k5WcIirkd0Axc6gX4
	 arqtMoqKxTsso9FhoKIKJOQCPtL+ScD83OsplHNqsByEB9YzabtaYBAl1gxjsd5Pv9
	 Bz0oC36jNW8XArDHuqQaKRgmMm9HM98JIrxEgBr/S5kHj60CXaIdNLwMpoDiEd10MB
	 ZpVNw5zlkJzng==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8FC04CE0A73; Wed,  5 Jun 2024 11:30:15 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:30:15 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	rostedt@goodmis.org,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rcu 1/2] doc: Update Tasks RCU and Tasks Rude RCU
 description in Requirements.rst
Message-ID: <70b7fde1-1a94-4a95-837e-e2402a3898e7@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <e5dc5f14-04c1-494b-9044-e837279a7bcd@paulmck-laptop>
 <20240604222155.2370541-1-paulmck@kernel.org>
 <ZmBPF-a-qPk_bLbG@localhost.localdomain>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmBPF-a-qPk_bLbG@localhost.localdomain>

On Wed, Jun 05, 2024 at 01:42:15PM +0200, Frederic Weisbecker wrote:
> Le Tue, Jun 04, 2024 at 03:21:54PM -0700, Paul E. McKenney a écrit :
> > This commit adds more detail to the Tasks RCU and Tasks Rude RCU
> > descriptions in Requirements.rst.  While in the area, add Tasks Trace
> > RCU to the Tasks-RCU table of contents.
> > 
> > Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

I will apply this on my next rebase, thank you!

							Thanx, Paul
