Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6072DB798
	for <rcu@vger.kernel.org>; Thu, 18 Jun 2026 01:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781747090; cv=none; b=QHZnGiDm8hPYSnxqw5mp0FJR7yaUeWzWF0XW6oc02SmvdgGuoOJPFIduDcLQY2eBnJieWAorsmqVztQ5defe/74yBivIrDNLu5k5ujx2HNY6TGH7mgqnPBJXHptNt+Gofe62ctXupbuWwrC0RwYZjH4R0yaZyJ+jJh0gVKsLZlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781747090; c=relaxed/simple;
	bh=MA97i8ZFd22Ja0P77uimpuoQ4H+PreSlSaN2v78FnYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QH9WnYn35+X6rpRI9vGG/egukde29wtDWocxfDh9x2Qjk9o0XDLzzyTUA6TQBxTpKv4sLbKtBUQABRD85uZO6p4wwiU6uunCfpordfw+wdg6HHauMYJW8dfXhY7JEl4vteMEhLUeVmcUjgfCGVrZWrQfBMBuF4fi5zw0mzHoSuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=WX+kyF+o; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="WX+kyF+o"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-9158c621ebbso49094185a.2
        for <rcu@vger.kernel.org>; Wed, 17 Jun 2026 18:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1781747088; x=1782351888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BknC521z3j7HYlZ+93y/0lWMWDCjeC/ViP/zZCod4gA=;
        b=WX+kyF+oEUoZ2u8LBnwsmec1c1TXPmBIUxTIhuIbIcwSYV3UjhY90GsPxMe1AZ647v
         h3QjYCfPK5y+KhIzc3gpJCQyssVSC+Wtq2RFDWTLbNx4lSvLvFT+5JDlzzoG/QOmuYGM
         6MMa9hvs1ggwMV0hWj4wit2gv2CEWgLpOgFvho8us7P1bt2+fFN0Esc8RE4ZzNJRoH0B
         HM0nYMGeSyNGSRgtZgu39GmZ4/GLGeLB5ODq99Askh4qDr3IW1zFHKTjX/ZNaIEtoqA+
         Ym04Tqebiy2eXjjuMYxfy7qb08RhxXcYwjlDItcAUab8WS7fBwYtYwi7sTTXZiUTawQm
         KH+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781747088; x=1782351888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BknC521z3j7HYlZ+93y/0lWMWDCjeC/ViP/zZCod4gA=;
        b=TXcrgYBi/0y7LXn/ib+oxurFmz0N+0QCb2jsgSn9SLGRqrvyMcb17oUNbU3sy50qaP
         CqO/Dv1aWjk/38/eSQeGcJ6TxtxVvWquxbgx7ExKQ3dQjpZpfThzG4tGXcqHmr4ihPUl
         pTEeveHPiy7MX2Eika7SVU79FCcSE5eV0IM694+Sv4lTBngMIQdCJRfZBztoZpCoT2j8
         P1bk3BNUMfxC6e13K54yCSxKf/vZ81lkr59HtyPyJxQ1iJ/GE+SyRo3pYdsfmC7la0cc
         dAnDhby8TXsNjHFAqCEbpW+f9++aVlXmyaYu8+8uRtVGf5UPm18T4jU0DCjCHU//HG1U
         L2YA==
X-Forwarded-Encrypted: i=1; AFNElJ93YSfiA5Bwr0nq2nIu4qjzF/TVZEtG7T+bntUHTEsCCF1Lj+V2wHp72CC3ftZEiJzD0OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIzXRFOV7A2jS9pNTvGaST/BjRhnyc4BZT6EEu7k9//WA4ckxQ
	ye95dAhO1hMtQexT6eMdpm2gL2KpLbH2qwEv/8wGeNnYT/deh4JedsY1+9I+2GbFYw==
X-Gm-Gg: Acq92OEWSMpmUroAAMPRAVCg69HbKw8/W356UvL7qExSBoS5eXehm7AMbAHedn9Mksk
	w3YCDIqUAuraU6ozw4rIih5ZL9hh6eMdJWA3g0fNAI3yaRzCFTF3686zQ5j9JK5bUnbbKCyOoJi
	aifQxCfCCR46n6/IZ2feTGNV4i/3hFCI8cfXOBSCLyEqYXSDueqBbGwl0Bl4mDFWEz+eTcdxqts
	yXpgva688O00QDyGXFV+XdDMjDGd9fOWBeMYiNB6zc3Q/CRzjfGR8O7W08IrzsPv2LRm8Pu5kZ8
	J4L4NSgdcOgmmA5THyQCqZdHXMdpeM+8CFdkDNKPh1Y5a6hIVWyHLPSEaX1LWLqniEae9J+j8NO
	Tnms9eW+m8BzQPeQe5riedL7TUbIm5BZHbwnU6iudfC9JgZDV11BQkCcWOh8BcicLV+u0PN/63k
	RRB2Tt4EeItBvaFkO75SSD+JDrCQRs/rid
X-Received: by 2002:a05:620a:2b43:b0:914:9bed:9443 with SMTP id af79cd13be357-91f2b7761d8mr250318985a.25.1781747087645;
        Wed, 17 Jun 2026 18:44:47 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619f3c324sm1923222385a.21.2026.06.17.18.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 18:44:47 -0700 (PDT)
Date: Wed, 17 Jun 2026 21:44:44 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Usama Arif <usama.arif@linux.dev>
Cc: lkmm@lists.linux.dev, joelagnelf@nvidia.com,
	linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
	paulmck@kernel.org, rafael.j.wysocki@intel.com,
	rdunlap@infradead.org, riel@surriel.com, sshegde@linux.ibm.com,
	tglx@kernel.org, ulfh@kernel.org, yury.norov@gmail.com,
	rcu@vger.kernel.org, shakeel.butt@linux.dev, hannes@cmpxchg.org,
	kernel-team@meta.com
Subject: Re: [PATCH] smp: Use release stores for csd_lock_record() state
Message-ID: <831f9fb1-82a5-46ba-9541-b82c94e43639@rowland.harvard.edu>
References: <20260617212001.3658605-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617212001.3658605-1-usama.arif@linux.dev>

On Wed, Jun 17, 2026 at 02:20:01PM -0700, Usama Arif wrote:
> __csd_lock_record() publishes per-CPU CSD debug state that is read by
> csd_lock_wait_toolong() on another CPU.  The remote side first reads
> cur_csd with smp_load_acquire() and, when non-NULL, may then read the
> matching cur_csd_func and cur_csd_info fields.
> 
> Use smp_store_release() when publishing cur_csd so that the preceding
> cur_csd_func and cur_csd_info stores are ordered before the pointer
> that csd_lock_wait_toolong() acquires.  This replaces the open-coded
> smp_wmb() plus plain cur_csd store with the release operation that
> matches the smp_load_acquire() in csd_lock_wait_toolong().
> 
> For the clear path, use smp_store_release(&cur_csd, NULL) so that
> clearing the diagnostic state remains ordered after the preceding
> callback/unlock work, without requiring a full barrier before the
> store.  On x86 this removes the locked full barrier from the clear
> path; on weaker memory models it uses the release operation needed by
> the smp_load_acquire() in csd_lock_wait_toolong().
> 
> The old code also had smp_mb() calls around cur_csd updates. Those would
> only be needed if cur_csd were treated as an exact live-state marker whose
> publication had to be observed before callback execution or CSD unlock.
> CSD stall warnings do not currently have RCU-style stall-ended checks, so
> they already allow the stall to end while diagnostics are being assembled.
> The cur_csd record is therefore best-effort diagnostic context, not a
> precise completion/stall boundary.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  kernel/smp.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index a0bb56bd8dda..5ba4a20ba77d 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -182,16 +182,12 @@ static atomic_t csd_bug_count = ATOMIC_INIT(0);
>  static void __csd_lock_record(call_single_data_t *csd)
>  {
>  	if (!csd) {
> -		smp_mb(); /* NULL cur_csd after unlock. */
> -		__this_cpu_write(cur_csd, NULL);
> +		smp_store_release(this_cpu_ptr(&cur_csd), NULL);
>  		return;
>  	}
>  	__this_cpu_write(cur_csd_func, csd->func);
>  	__this_cpu_write(cur_csd_info, csd->info);
> -	smp_wmb(); /* func and info before csd. */
> -	__this_cpu_write(cur_csd, csd);
> -	smp_mb(); /* Update cur_csd before function call. */
> -		  /* Or before unlock, as the case may be. */
> +	smp_store_release(this_cpu_ptr(&cur_csd), csd);

Isn't there a general policy in the kernel that memory barriers should 
be accompanied by a comment explaining what other memory barriers they 
synchronize with?  Including such comments is a good idea in any case.

Alan Stern
