Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24D113DDAA;
	Wed, 11 Mar 2026 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234189; cv=none; b=AcE5t2fdEw9rBBQElVQOwF2ebZC2uaLjHzjbgL9FxMU5vmX18zx4zAnQmv1VUfIbnxacEa4AEwryhfo2h3d5W28zGzFmm3J8juV/DRWGRRKPMNzUHdNs9KZoOunOQa6qgCqbU3DpoY5LgeruSfThda5aWy7SPzVcng07sx3oh7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234189; c=relaxed/simple;
	bh=OJxCdxvlU27pzD8D/81cIy79DuDkO/BzGCDZx/112fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O7b234powSWV5T0Am2b92wQFus4Tkp0iJvAtmMhmMqolZKIjOBKz9AkMIwqqBiX6uEzLLh1Rxq+40a1aw62hvMbHHn3myaPErSsUZbL5VafV3XTvqxnPZtEfNxxswlA3TF4h2ZEXLeO+x2K6HK480yyte6j9wHu4NwcQnI09SLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uk8aXdB+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uk8aXdB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88DAC4CEF7;
	Wed, 11 Mar 2026 13:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773234189;
	bh=OJxCdxvlU27pzD8D/81cIy79DuDkO/BzGCDZx/112fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uk8aXdB+KyESDC1AK9/hsJvRJzM/sBIJs9fmhNZd3D2GqtIhzfHB2nZDmIZnYNdTo
	 kj5kG6c1rZj0D/mGI4AqEvoRaUiLj5rkM1qJprWcEiYDsW7LgSpVpSOsYkgYpHPedJ
	 QTncyGOgev3qm4lwOI6py7DKaOR4pJRoM6oMHp5BblJJQy56UdSb50BRfKG1WV++w/
	 BGZVqpOWVPbba4gYz9k/rvB6zSJdUJWiI9M2nKbNffsAxVm+Q34oyCyK1fN1Mfw9EY
	 8ACjCbrlhOiltBE2tNFy09/aeMfCcpREtCmwwaAo7qSzlv0tpkqbbKSf1ehSdFHm7P
	 82buU1n4WbSPg==
Date: Wed, 11 Mar 2026 14:03:06 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC v1 4/4] rcutorture: Add NOCB02 config for nocb poll
 mode testing
Message-ID: <abFoCv6FDM61ev-e@localhost.localdomain>
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
 <20260224230435.3390963-5-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224230435.3390963-5-joelagnelf@nvidia.com>

Le Tue, Feb 24, 2026 at 06:04:35PM -0500, Joel Fernandes a écrit :
> Add new rcutorture config NOCB02 that enables rcu_nocb_poll boot
> parameter combined with CONFIG_RCU_NOCB_CPU to exercise the polling
> mode code paths in the NOCB implementation.
> 
> This config exercises poll-mode paths not covered by other configs,
> where callback invocation uses active polling instead of kthread
> wakeups.
> 
> This config is not added to CFLIST to avoid increasing the default
> test duration; it can be run explicitly when poll-mode testing
> is needed.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
