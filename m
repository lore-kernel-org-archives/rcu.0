Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A30727F01E;
	Wed, 11 Mar 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773234160; cv=none; b=HkyxYDMQ/sd6f5Y+WmWHdc1K1Zq7tGylN695UdrBUn/+/MS/A7sj49LfeyvWmCnueACN52U9dYr/jtizMWM6K+DjuEeWEfKl+X8EQby2pRYjwKS6FVUKwhRd2r5tcPCe2N59RqR3+4QvUtzuEBEqzX05fsWI12Domtl10f+kQ0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773234160; c=relaxed/simple;
	bh=zm8V6/2g9JlwLptnl46Ce4LjTRSIJS4bxdjanlm6lVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hj85wPa6HOY7ej1emSh/X8VSkF4QELvEZpqJvna3MOlVAFQgIhNKzvUxWeEi9EqKaB2TD82eXrh1bIMyOMaFiJWj1TvKnAB1Spf2QI0/31B8Lx82XAfxs60R3iDcTnQUMSkHEiViTYWOkCrnNujOmMDSqPreoScLKumTm962bYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzzowgXg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzzowgXg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3BAC4CEF7;
	Wed, 11 Mar 2026 13:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773234159;
	bh=zm8V6/2g9JlwLptnl46Ce4LjTRSIJS4bxdjanlm6lVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IzzowgXg0s/NIX1yCOmFNJrlYa0817wS8sqDKntKTALVNr+8/1wfypl6PacGc7Xw+
	 7EsIhIqyz94OTIZvbfH8by/KyQL/wGUD3uDHhQuF/Wlqi2jY94LIZXhHdCadosd75t
	 oeX+z7cf2qvoKRtsWwBMy0mlLCFlGHz6B5WUKeqGCMR4DMx//AR7ET4whtWnc0LUhz
	 Z/bGQvIhTFzngj1mdw1XfJBJcUjQL1gA+9dOhDyriwkxCitMoanlUAMveJbRz/yONG
	 TQjLn+GxcmF/1bi+8HLpx0u2m3LH7eO0sCppI7YV227qYqst6lzmVEpPZkmnRS8MfZ
	 lK5lHG8ZNtaLA==
Date: Wed, 11 Mar 2026 14:02:37 +0100
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
Subject: Re: [PATCH RFC v1 3/4] rcutorture: Add NOCB01 config for RCU_LAZY
 torture testing
Message-ID: <abFn7Yb2Or6QTV01@localhost.localdomain>
References: <20260224230435.3390963-1-joelagnelf@nvidia.com>
 <20260224230435.3390963-4-joelagnelf@nvidia.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260224230435.3390963-4-joelagnelf@nvidia.com>

Le Tue, Feb 24, 2026 at 06:04:34PM -0500, Joel Fernandes a écrit :
> Add new rcutorture config NOCB01 that enables CONFIG_RCU_LAZY combined
> with CONFIG_RCU_NOCB_CPU to exercise the lazy callback code paths in
> the NOCB implementation.
> 
> This config exercises lazy callback paths not covered by other configs,
> including lazy-only wake and lazy defer logic.
> 
> This config is not added to CFLIST to avoid increasing the default
> test duration; it can be run explicitly when lazy callback testing
> is needed.
> 
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Acked-by: Frederic Weisbecker <frederic@kernel.org>

-- 
Frederic Weisbecker
SUSE Labs
