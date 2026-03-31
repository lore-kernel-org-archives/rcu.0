Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1096D351C22;
	Tue, 31 Mar 2026 09:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774950035; cv=none; b=kaM5VkK4WwMaEpdwBrDywzBYRTg9ko4+rsaAqJFWDJ6Uwvp6mjR8EAijm/bwc55wRWF4OOdX7nZ522hE4tyZuVHrlyK5Izwcq/eq+hUBgiU2rUgETftz3Bsc/85mDwY5g3Ti0+e5E/Zsv+Xypkb65tW4iXSwPgEe65ROPdm+Hkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774950035; c=relaxed/simple;
	bh=uJMOWgINMXub8AP/Kf/qJSBe/DsTYp4xy6LyAUAYweU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zys3/ZyqtyhPxoGzYSxtvg7w8K3di1sIccdrVu4iKrHPAwot0E+xpQTKHg4wxNb6WtZlbTHAme1zW51mvQdj9KMDkObMBFCt8SeT/+wKfJU6pmqCBvBZSRVxmWePcAXY5p0Ell6ywzaPBFXywCPYMNjmLyHyEQFDnQY+OGCjAbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vi8vFZls; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vi8vFZls"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C4AC19423;
	Tue, 31 Mar 2026 09:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774950034;
	bh=uJMOWgINMXub8AP/Kf/qJSBe/DsTYp4xy6LyAUAYweU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vi8vFZlsgoCOH/wPS5qHFh+9FlxjtYdO3E6n4rykwKM/RFhjQSAm2r0FAcCfmxanX
	 8cDLuK9RMpqSLWUMKTYfvECTFdHSJ0adVPlDrHbPx18NGRCvaHyN65bWIGcLnoIfVY
	 0C4giDsiuFPLuJ/vb4OkMsYv4rOxn15A8xHyWPVgoneACXn7syXg2Wm1YWElxFnNSW
	 8lxDHaY7Q9beZxlUPgtPs67a4ginIchALCbX8EkYz6uBIYr3k805VD1JadWExZQR9B
	 obrhXR5VgZKWF1oYiRiT1wHxL/MTXg+JqgNaWWaTwUnQM3/bAnX3LoJQPWCzmCJjEj
	 oCogtt1sZFE1w==
Date: Tue, 31 Mar 2026 11:40:32 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang@linux.dev>, Tejun Heo <tj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 09/15] mm/compaction: Support dynamic housekeeping mask
 updates for kcompactd
Message-ID: <acuWkL9QHEUG7Olp@pavilion.home>
References: <20260325-dhei-v12-final-v1-0-919cca23cadf@gmail.com>
 <20260325-dhei-v12-final-v1-9-919cca23cadf@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325-dhei-v12-final-v1-9-919cca23cadf@gmail.com>

Le Wed, Mar 25, 2026 at 05:09:40PM +0800, Qiliang Yuan a écrit :
> The kcompactd threads are affined to housekeeping CPUs (HK_TYPE_DOMAIN)
> at boot to avoid interference with isolated workloads. Currently,
> these threads do not migrate when the housekeeping boundaries are
> reconfigured at runtime.
> 
> Implement a housekeeping notifier to synchronize kcompactd affinity.
> 
> This ensures that background compaction threads honor the dynamic
> isolation boundaries configured via the DHEI sysfs interface.
> 
> Signed-off-by: Qiliang Yuan <realwujing@gmail.com>

Unbound kthreads are now handled by HK_TYPE_DOMAIN dynamically.

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
