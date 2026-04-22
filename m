Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9C62FDC3C
	for <rcu@vger.kernel.org>; Wed, 22 Apr 2026 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776827508; cv=none; b=BbSV3ltGsRbwaLrlNroXb+tuO3FT/o3dgGs/bhVdm3dO9T0En2UFqliVO1LDVXtcmcd1Xi0SYeAwSKzbJ1IouDc40TUNd6lV6JABXoZuIv9moHVJlGqW8P1Ie6RqqxmEvM+fAEgnyALE8q6gufOD4a4aqtj4iYWoe2kFJTq2d30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776827508; c=relaxed/simple;
	bh=kyDmemKWiRVmNcj8mIjUyyIMCr2+tlzmxpx6KyHDAgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/jG/YcSsf7SzPQtION4XYrxKIJ1QFLEPHSMzVpopcvTrDOp6vN/hLse/nglRXDrDLym1YvrMoJEBmE1pHEVD4Nn3NGDfu4A2yeHAV1Z1SG1SGuOIY0qi3uYNtxWc32rfMjuPd56Cux5HRRWPT6med/qySgrKkKPSeEZzopTF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9K/S7g8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9K/S7g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4F2C2BCB0;
	Wed, 22 Apr 2026 03:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776827506;
	bh=kyDmemKWiRVmNcj8mIjUyyIMCr2+tlzmxpx6KyHDAgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9K/S7g82VubryvntE7tz9shrxbGo6BMot8rVkwMFJUhKTxw7lLPIsHVBTazfsHyr
	 nJ7r+a7qeWjau9IqpxLfqG4iFDYZZ6G4+BLbdNbBiXpPwL0ggI2dhNosCaeXJOktMl
	 JUDbI/ycmVAJxq/xHF6O+N06DvPoJXyXVEG4H++ENlxs2eGQusbJ24hDyNOnQaQRtX
	 wvp1c/4aHF7l9ZaOceGo6nmwMC3mwrmv8BKqgP7SmgG3W/ARRm6U/2cnDQw4wBXNKe
	 Ee+O2yllstfEnczIQgNjqZvEGPWyuNJqGpOZPmX6v3xr0e1e3vFZLE8RGdFLjMbF7N
	 +ySpw+V0a8LIg==
Date: Wed, 22 Apr 2026 12:11:44 +0900
From: "Harry Yoo (Oracle)" <harry@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hao Li <hao.li@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Zqiang <qiang.zhang@linux.dev>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>, rcu@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 7/8] mm/slab: introduce deferred submission of rcu sheaves
Message-ID: <aeg8cLodwO8tCurb@hyeyoo>
References: <20260416091022.36823-1-harry@kernel.org>
 <20260416091022.36823-8-harry@kernel.org>
 <DHZ78L9HZ1YE.JY63DXXMN9NF@gmail.com>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHZ78L9HZ1YE.JY63DXXMN9NF@gmail.com>

On Tue, Apr 21, 2026 at 03:51:02PM -0700, Alexei Starovoitov wrote:
> On Thu Apr 16, 2026 at 2:10 AM PDT, Harry Yoo (Oracle) wrote:
> > Instead of falling back when the rcu sheaf becomes full, implement
> > deferred submission of rcu sheaves. If kfree_rcu_sheaf() is invoked
> > by kfree_rcu_nolock() (!allow_spin) and IRQs are disabled, the CPU might
> > be in the middle of call_rcu() and thus defer call_rcu() with irq_work.
> >
> > Submit all deferred RCU sheaves to call_rcu() before calling
> > rcu_barrier() to ensure the promise of kvfree_rcu_barrier().
> >
> > An alternative approach could be to implement this in the RCU subsystem,
> > tracking if it's safe to call call_rcu() and allowing falling back to
> > deferred call_rcu() at the cost of more expensive rcu_barrier() calls.
> 
> Yeah. call_rcu_nolock() will be really handy here and in other places.

*curiously watching whether RCU folks show interest, so that he could
 drop ad-hoc code in slab*

> When you respin pls pick some tree that sashiko knows about.

Yeah, adding base-commit id appareantly didn't help.
Sashiko doesn't know that we have the slab tree :'(

> So it can apply it all and review it all.
> Currently it reviewed only patch 1 and failed to apply the most interesting 4+
> https://sashiko.dev/#/patchset/20260416091022.36823-1-harry%40kernel.org

I heard that at least Sashiko knows about mm, linux-next, and mainline
trees. Will try linux-next next time.

-- 
Cheers,
Harry / Hyeonggon
