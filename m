Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7A938A718;
	Mon, 29 Jun 2026 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782733963; cv=none; b=gbgQ9Bd+3Ai044w+IFKo63cIoGW38euL9/iNwhYRFLz8UyVc3F3Jvmv7frPIoXLV6UWW7c/nZXJg5TcGmVjCZESe0zRmpp8YJBN2LincdWF7wkrCcscf+WmpftjopvPkcIWxbPvHjmz5MjBoTKqH3S9qgSWJQAF0wqrMCL7GH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782733963; c=relaxed/simple;
	bh=xtLv8sx7o2vu88+5bTJd6lCWzHVWvMnl3aeynhEfhb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/29ByHm4shTBr2doEjb+bqEqdW4o0NWhoT0c/zPOorlIiuY345Rrs9SDbLhCTxJZRMV5KfOaZr2ORsjzT6fJhTSpb7EtlcfRkMRZGVILUiwfO65McT9gSanzFZ+fWMnTfLMAK2CB+a9I3HnNHoS7C2xcJcUlr/2oIs1S1mHgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=chdqbk9q; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="chdqbk9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1782733953;
	bh=VuoHijUEJruN0l37nATXYONs5p1PFg9Pl86mWtiLSL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=chdqbk9qAxxpuQLfSA1yhQZzg7qNFu2MRnBFtdixvJQTEBTL56PIxRHropancUZ36
	 BMJtEDtcHblWWEnFVbCW6ikVMhXJREAKl/qOwdkmDJ50pDRDyW/yNP31SfhkMrpNeN
	 OwTajzoKRES8upP4dmxqBFDMsJ3h+Zv+oQM7yka4=
Received: from shell.ilvokhin.com (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 98175DB1EA;
	Mon, 29 Jun 2026 11:52:33 +0000 (UTC)
Date: Mon, 29 Jun 2026 11:52:32 +0000
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: lkmm@lists.linux.dev, joelagnelf@nvidia.com,
	linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
	paulmck@kernel.org, rafael.j.wysocki@intel.com,
	rdunlap@infradead.org, sshegde@linux.ibm.com, tglx@kernel.org,
	ulfh@kernel.org, vineeth@bitbyteword.org, yury.norov@gmail.com,
	rcu@vger.kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	kernel-team@meta.com
Subject: Re: [PATCH v3] smp: Use release stores for csd_lock_record() state
Message-ID: <akJcgCCMphB64Euj@shell.ilvokhin.com>
References: <20260629105745.1696683-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629105745.1696683-1-usama.arif@linux.dev>

On Mon, Jun 29, 2026 at 03:57:45AM -0700, Usama Arif wrote:
> __csd_lock_record() publishes per-CPU diagnostic state (cur_csd,
> cur_csd_func, cur_csd_info) that is consumed from a remote CPU by
> csd_lock_wait_toolong() via smp_load_acquire(&cur_csd). To order the
> matching cur_csd_func/cur_csd_info stores before the cur_csd
> publication, the producer issues smp_wmb() before writing cur_csd;
> to order the publication before the subsequent callback execution or
> CSD unlock, it issues smp_mb() after the write. The clear path
> mirrors this with smp_mb() before storing NULL into cur_csd so the
> preceding callback/unlock is observed first.
> 
> The smp_mb() pair is heavier than what the consumer actually
> requires (on x86 each emits a locked full barrier). The consumer
> only needs to observe the matching cur_csd_func/cur_csd_info when it
> sees a non-NULL cur_csd, and to observe the preceding callback/unlock
> when it sees NULL -- both of which a release/acquire pair provides.
> The extra two-way ordering enforced by smp_mb() -- that cur_csd
> publication be observed before callback execution or unlock becomes
> visible -- would only matter if cur_csd were an exact live-state
> marker. csd_lock_wait_toolong() does not treat it that way: it
> snapshots cur_csd via smp_load_acquire() and then prints / dumps /
> re-IPIs without an RCU-style stall-ended recheck, so the diagnostic
> already tolerates the remote CPU completing its work between snapshot
> and report. cur_csd is best-effort context, not a precise stall
> boundary.
> 
> Replace the smp_wmb() + plain store + smp_mb() in the publish path,
> and the smp_mb() + plain store in the clear path, with
> smp_store_release(). This pairs with the smp_load_acquire() in
> csd_lock_wait_toolong(): preceding cur_csd_func/cur_csd_info stores
> become visible before a remote reader observes the non-NULL
> publication, and any preceding callback/unlock becomes visible before
> a reader observes the NULL clear.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Reviewed-by: Dmitry Ilvokhin <d@ilvokhin.com>

