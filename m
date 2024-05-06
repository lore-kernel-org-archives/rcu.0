Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B88CEBB;
	Mon,  6 May 2024 21:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029610; cv=none; b=CgVqjDdnhTX3SCFuuHv7bczy1PLZvpGfWIm7F9e51X8EYJRRrt93jPIy2zIg8DFMCXOrPG6jlDEKZXCxMmHJXin5pa5mqdafEUvayMXYpYjo8VWku1cnXgGUHcvvsvODc8E4s3l9PrGDqcs/tCA+NHXv2+OkPR2vn7l7opBa6TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029610; c=relaxed/simple;
	bh=/+VlvJCxmovRUjBeYipYCkRqJYEe21p4NqDhyZTOLNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mohfasc1K4lky/Fdgl+qXrJeKP3ip5YyUwh/7Z3Z6brIBFre54aOHiZcuLeX7N9JV48QsQG4qdG1KAGfidWWTkW+hX6E9e4lqbmO77gHOGaiigS96Xr36CKVFiohnR2LZDp4kzcvzTKSp+5PWFaIWAVRmpZdMbOr7bhomKMVjgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6KHwldg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6KHwldg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59AE1C116B1;
	Mon,  6 May 2024 21:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715029609;
	bh=/+VlvJCxmovRUjBeYipYCkRqJYEe21p4NqDhyZTOLNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N6KHwldgTClgYuDnnCHtyT5NaH25YpzhpW/O/muJEBTZ+M3Bb7xZ3D5I0xHZTE+qw
	 pxoFuWQAjly81dSaFwINcEvAVmjSJ8CFg/Nf49xso7W+YzvqNvjFmH+syC96fA37ZS
	 ERjEl6mUQHXKWAZLg0whkQH/qKd5yj6nDDKujGxWVEEdaKoa4CQ5utvQAag6ofYyE5
	 83WRTM6BK+5iDvHbJ5ASziOlAXlL4FVUbbQKK7UOycAaJe3w/hNG3lSqcz0Nyubwr3
	 DuzF2Vvq1As0Myi1h0k97l9SZCQRKsmXnhWgwate8qZYYf090m0DQpmvSpYsQDJ+hH
	 GtV+OFRlNNqDg==
Date: Mon, 6 May 2024 23:06:46 +0200
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
Subject: Re: [PATCH v2 12/27] context_tracking, rcu: Rename
 DYNTICK_IRQ_NONIDLE into CT_NESTING_IRQ_NONIDLE
Message-ID: <ZjlGZnbOIDMa7T9e@pavilion.home>
References: <20240430091740.1826862-1-vschneid@redhat.com>
 <20240430091740.1826862-13-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240430091740.1826862-13-vschneid@redhat.com>

Le Tue, Apr 30, 2024 at 11:17:16AM +0200, Valentin Schneider a écrit :
> The context_tracking.state RCU_DYNTICKS subvariable has been renamed to
> RCU_WATCHING, and the 'dynticks' prefix can be dropped without losing any
> meaning.
> 
> Signed-off-by: Valentin Schneider <vschneid@redhat.com>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
