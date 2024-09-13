Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D67F460;
	Fri, 13 Sep 2024 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263866; cv=none; b=QVrYcPMIssYLVGlfqGKz9oWsuZXbkC996ZQGvDqadIPDRmLIukEYP5LoQHgzMisIDXrG0OoGE03Fty8bzW3FQuOEm/hj6pSzczWQX+80c2hIRSafzKh/amEKQxlQhmEmO98s8wULILyH2ALWocPkE6cgMuA1muIw+thg9FXNgQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263866; c=relaxed/simple;
	bh=0qZpgua4L0xrtWkUfIR6unEX4LXRvx7Pt6VezLDtDeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bBIWe+Gze2IwRYU7FvUXPEo0io5CG++8sRjhnrYDWjZ1zUduBPl0kAbEMwU+0kfiekBUlZGK5N4MWbmuPNEKoTMYeLlebty/2E06XmEi779idaaYoZx3IQa33XxoTJfBgeYPceJDGKxviExsWJ4nBAByBGPlNFk4sWTHRNBEnw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDGjjDCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDGjjDCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFAA0C4CEC0;
	Fri, 13 Sep 2024 21:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726263866;
	bh=0qZpgua4L0xrtWkUfIR6unEX4LXRvx7Pt6VezLDtDeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDGjjDCoe3ljU2LTBneE7fwJ+vGP+DhxIpnFjUD6TVcLlrARRVYetn/38/12r8k64
	 l0/KS/AQYc0gs8N1L0vRva4anmO1FGgqtRbpOf4zX3Eg4kxcAhvKCFNJF6dXA7/kdw
	 lTALwyMBZew240jI8W2g9eGorAVDl249MNWoOg2U6Ti911YESKSloazxVWz39wRMN5
	 tDIRup2hcWmepqGHVemmC4cA1bgI9Rvr/6i+w3Q5wyDEztTi7T+y0Wsvh9uccWPq4b
	 2lvgcvZlHzcXur/X127aDE6DyqXrTRSGlS6dRMXoAkysZAenE16a+jTScdQUxyBjPY
	 8CbCUpMXJgERw==
Date: Fri, 13 Sep 2024 23:44:23 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	Cheng-Jui Wang <Cheng-Jui.Wang@mediatek.com>
Subject: Re: [PATCH 0/3] rcu/nocb updates
Message-ID: <ZuSyN_1jKUrVAprO@pavilion.home>
References: <20240913214205.12359-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240913214205.12359-1-frederic@kernel.org>

Le Fri, Sep 13, 2024 at 11:42:02PM +0200, Frederic Weisbecker a écrit :
> Hi,
> 
> This series include:
> 
> * Fix another RT wake up while CPU is offline (reported by Cheng-Jui Wang)
> * Cleanup rcuo wakeup
> * Remove another superfluous barrier
> 
> Thanks.
> 
> Frederic Weisbecker (3):
>   rcu/nocb: Fix RT throttling hrtimer armed from offline CPU
>   rcu/nocb: Conditionally wake up rcuo if not already waiting on GP
>   rcu/nocb: Remove superfluous memory barrier after bypass enqueue
> 
>  kernel/rcu/tree_nocb.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Please discard this series. It has been applied already. Scripting error...
