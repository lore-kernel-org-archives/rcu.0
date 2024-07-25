Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546419AA59;
	Thu, 25 Jul 2024 12:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910250; cv=none; b=MwqhwkYyASm+reXcjGelgt1jzPIeaeCVci0DU/mhLD8nAXsBsE02r/kYJs58QCneKrABKuolIbira4obBjEzgM8aJZ4ScOXOnMjid0iVKqrNQTo6nbC1Sb9r67moXHHWA37ypfi2uqouvgGpZ5+p/ULgc9hvqaxQggin9KziXyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910250; c=relaxed/simple;
	bh=qhWqTS8Ulw609L+HxG78B9+hQiB04CRryb28DdcZsno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZ3eI7loeFnu2dtNg8zMnnh2vtIFX+oVjNdwlmUBZS7tqJ36RELlr9TVBX2WwqOKqGK6yjR/I9VHFcvWHoeEEmvQSCwJTElwPo1nZCKxekVE7cw0hQLK6hDBg7U7uVwBnKZF29//g0cLxV5Ue7T/Nq0glxiiFFLA9SybzY2OdoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iybqO3oR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iybqO3oR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319BBC32782;
	Thu, 25 Jul 2024 12:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721910249;
	bh=qhWqTS8Ulw609L+HxG78B9+hQiB04CRryb28DdcZsno=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iybqO3oRvOTsveBaRSxyiMrJaVFMvVf0jEXajlOOH6G3Rb+m/i45mP3oGY/U+9mXe
	 IwLEsrlfuILoVgwHBVMBTWwU6hMkj+Jia+HKf30TPmqyevg5Amj+OT40V4XIfLZcfr
	 R2cuX+I/B0rkeRiCP0Rev0FEYumRTqxH/7ajgCalt3CsO6vddWtmGaNb9FNFNnhLF4
	 721vn4uTRXYT9VX+4AU8Jdsq3oy4zmbGi+OFKsqD8jmaSEczW3J5d8HVTt1gz4I81T
	 a4Gh1a9xcYsrEBIpj2zXkTbUrtPRTY1XNmmEjyF49SDA77Yo/vUY8XT+EuLtuMmPZU
	 3uGCGtd8fHNhA==
Date: Thu, 25 Jul 2024 14:24:06 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Valentin Schneider <vschneid@redhat.com>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH v3 21/25] rcu: Rename dyntick_save_progress_counter()
 into rcu_watching_snap_save()
Message-ID: <ZqJD5qPiJicPAR3G@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-22-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-22-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:21PM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> meaning.
> 
> Suggested-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
