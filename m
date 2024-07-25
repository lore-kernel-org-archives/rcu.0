Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF2199E9F;
	Thu, 25 Jul 2024 12:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910084; cv=none; b=ef5c1PyexV8TQTV8UehYHejp/+Vqx3sJ1G5lcT/xl/DJAy3G4P/97cR5Xbo2qDnhbjiWYuABgkeQUb2e7eprJQYAbF8Hv6+AueKW5tSJ9fHaQIKfxypLnpM8aBKXd54lyVQdpkmTg1Enb8ul58YKQNtiTA+Hvpp+bAk0EPpIyRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910084; c=relaxed/simple;
	bh=vps1tIL5BK0lsVg6W/h0YW5iaRO5lqGUTLBhdTls6oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMrCwAUxJlzO/M456y4IkkIntso7JPOgoAmLvokuCs/QwjysESqZrLa21bG86hxQ+Xgmp7htMewhFpyCBLd0oIXUu3dSgcT0cIsaNyfGJfKrgPCwzD6ZRtB7LaISyhzUEXUc7k7f0OyRY9/VSTLNvRwbdYNaOKjYePOSSKwJyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHSi5PmD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHSi5PmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F44C116B1;
	Thu, 25 Jul 2024 12:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721910083;
	bh=vps1tIL5BK0lsVg6W/h0YW5iaRO5lqGUTLBhdTls6oM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHSi5PmDTNF2I6GvPdEwvPiIZJ0CL6MC3K5L/Gd9bj9Hq/tZCq4CcL6zMu1ksVTOn
	 IADEdJ+9WKJd3fAAwqe4w6lYg9jfy33x53EUTdrTEkS1XhBY4umSGBI+a7Xt9eyoLo
	 nm52owUyZBeUksQG2zSdXARUvY+iZb2MacAtUXLR7cyMDSXcNBK7G9MOhzeyNWZ74W
	 rY43o+338Uh094fAma4fBOGu4Sej5mlhBCDWmRjSvvO50eISvF5s6k5REjvXViP4aa
	 WPydBE4Ymos+f4hRNTCqX5bKM55DIhmu6CqOnFR8+6C8CVtBtaHlZAAIIJGl8wMwF7
	 we+hDL6CPL3iw==
Date: Thu, 25 Jul 2024 14:21:20 +0200
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
Subject: Re: [PATCH v3 19/25] rcu: Rename struct rcu_data .dynticks_snap into
 .watching_snap
Message-ID: <ZqJDQEDeU6_qUIDL@localhost.localdomain>
References: <20240724144325.3307148-1-vschneid@redhat.com>
 <20240724144325.3307148-20-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240724144325.3307148-20-vschneid@redhat.com>

Le Wed, Jul 24, 2024 at 04:43:19PM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the snapshot helpers are now prefix by
> "rcu_watching". Reflect that change into the storage variables for these
> snapshots.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
