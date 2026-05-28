Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC15B3E5EF7;
	Thu, 28 May 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779970452; cv=none; b=b23wj9ET4IhW4eCwfyRZZ8of5mnge7lADRxyOb+rVfttTwvhh9XlKFk+qeYJ+SfY+rSyiSqNuiJZWRhclMcQdLMrULETY4v3U4LJ8g1SPDi12GFLBryHSvI336AUtjyb2Cy4e/Z4YzzS1jQOmW0hYb7cU0+QAsaYjUzgR04ZyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779970452; c=relaxed/simple;
	bh=4cQ8JPoreDqCvQMxc5JhutCyP9TWFjFpKhB2mX5Lx0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KG3TjH0lXzaNRdQ4hQhZX+0QtF3fZ4vIcfjTFqzPt0XDcRxRfodvQ7n/LnSCcKboImwTyH0o0ZmzlrUISTT9LzIFOjifw50yN1UM2JoV4oPNTdn5TFotAa+TP9g1vVzT2HvGPVpdb9C7KkqjRFehWrFbHTGK3QmEj+sS/jngKGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldc/3XT1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldc/3XT1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BDF1F000E9;
	Thu, 28 May 2026 12:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779970451;
	bh=FaTVnsukxIfl+0vWTY2TN9FtaUmZpG/XWW5mvzVegDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ldc/3XT1hiStKinZPOAX3z7OZ/HKo3Av7lA+XdF+bnJ+Sr0jt31e4fBwyggpTjj9y
	 suK4JTOw+UjR2bxkZd2YbhND7qpI9hp5ZFx2C2zicJzJ/mDgM3fXSzSXdE4wxsSIDr
	 2oveZANOvaqX5ayNa9U1ujVZNTvLxEk5zEbvHI7OO+2fv+3SzMGRU8mCVkZJ51kq3Q
	 /JsRh07nxiB85smXCvolldzioNd4HcQvh2Nx13m4+59FPXzPvEFIdP7WGckoUBKxGA
	 p1DY59oETyE66/hxjEXaSeoFCPvOrb6hUSDhEFi9yGLZI/wOpkbo434fgeazUCpk4w
	 YLVjyW0bZbrtw==
Date: Thu, 28 May 2026 14:14:08 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Puranjay Mohan <puranjay@kernel.org>
Cc: rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH 00/10] RCU: Enable callbacks to benefit from
 expedited grace periods
Message-ID: <ahgxkIbBLkTJyUVt@localhost.localdomain>
References: <20260417231203.785172-1-puranjay@kernel.org>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260417231203.785172-1-puranjay@kernel.org>

Hi,

Le Fri, Apr 17, 2026 at 04:11:48PM -0700, Puranjay Mohan a écrit :
> RCU callbacks only track normal grace period sequence numbers. This
> means callbacks must wait for normal GPs even when expedited GPs have
> already elapsed.
> 
> This series tracks both normal and expedited GP sequences in the
> callback infrastructure using struct rcu_gp_oldstate, so callbacks
> advance when either GP type completes.

What is the motivation behind this? When most callbacks don't have much latency
requirements between queue and invocation?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
