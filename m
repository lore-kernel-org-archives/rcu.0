Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FBD2E041C;
	Mon, 21 Jul 2025 16:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115148; cv=none; b=hE/UXncunIMpmXB3QhIcZhysGG2rkAOpcwaeeZTYK9ewaSGWalfe+SSBByNuab14BOHdsOpiHkJ+afh7DivKHqTL1RtBvE7JnShn5ZB66lqkB4i9v1+ITfPBPQmVAnhb1JdavVskA4mWCFLkgi8LOlqMENDfIN+IjXMaLkBJI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115148; c=relaxed/simple;
	bh=sW77Chj1VfobyOSs7BgxGfiTeTWirWt7Uyul/PuwFdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A5v89aq1pekpn3o7XYaQI37lNAyWsFua8VXtcrGESv7mjJocn3+v0wef/leBpIA7adVDGMClz9WpcgOs1o+GZD1CO/HDcJCUWXMdAebV7ubwzewtxGvsK8f5xOJGjmPs2irLA8CcXcRWUVg0wud6QFrz1i49DLn4eN6QwldTi7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSVpOXFU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSVpOXFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD05BC4CEED;
	Mon, 21 Jul 2025 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115147;
	bh=sW77Chj1VfobyOSs7BgxGfiTeTWirWt7Uyul/PuwFdA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FSVpOXFUh1dTQJigwvZ0vUa47h3BXE9CUxruApkUpb7bg2H/YTmqWnC/gwhKDpO64
	 a5vWOxXXWy1GpgnNdsJI/mYn0HAIQp4+Zwd/a1GjI+7l0bHCP0rCcVGATepwlztmtV
	 U96lVnLCrypBT+wb8jU/MDZDar6oajHAWHLn8Fz3UGmyr9Jg6b/LUEaTY8WcO3ibpw
	 PtDG0TArFkA+cZ6mZuMCa3N/tefqojExWDbkRtv0Ch7ZMaME3wXb40XhB6xpwTGmr4
	 w8GU+0TXkVMlTOjx9G2YC9FE2CR4fadcyJemvMEinDih75izAaypeGgFlPv15VGmRV
	 SlYW1YLbNwLVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 6A0F8CE0C41; Mon, 21 Jul 2025 09:25:47 -0700 (PDT)
Date: Mon, 21 Jul 2025 09:25:47 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2 1/4] srcu: Move rcu_is_watching() checks to
 srcu_read_{,un}lock_fast()
Message-ID: <5c0894b9-9297-4729-b7d5-dea8997e1724@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <3cecf6c9-b2ee-4f34-9d1b-ca4cfb8e56a7@paulmck-laptop>
 <20250719002817.4121867-1-paulmck@kernel.org>
 <20250721105348.05312994@batman.local.home>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721105348.05312994@batman.local.home>

On Mon, Jul 21, 2025 at 10:53:48AM -0400, Steven Rostedt wrote:
> On Fri, 18 Jul 2025 17:28:14 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > The rcu_is_watching() warnings are currently in the SRCU-tree
> > implementations of __srcu_read_lock_fast() and __srcu_read_unlock_fast().
> > However, this makes it difficult to create _notrace variants of
> > srcu_read_lock_fast() and srcu_read_unlock_fast().  This commit therefore
> > moves these checks to srcu_read_lock_fast(), srcu_read_unlock_fast(),
> > srcu_down_read_fast(), and srcu_up_read_fast().
> > 
> 
> Paul,
> 
> Can you please send new versions of a patch set as a separate thread?
> It is really difficult to sort out what patch goes with what when they
> are all in the same thread. Even in tree view.

Here you go!

https://lore.kernel.org/all/7387f0c2-75bc-420d-aa7e-3a9ac72d369c@paulmck-laptop/

(Once lore picks it up, anyway.)

							Thanx, Paul
