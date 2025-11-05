Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2AC309EF9
	for <rcu@vger.kernel.org>; Wed,  5 Nov 2025 11:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762341922; cv=none; b=DdQgMw0NgQQJNnlqLyiYbWRIeDRoj6aMI4MDmfadfmUNUQsh8ZwTmZ416QG8mioceuKFIjShzOloIDxKHC1rIzncdXF1lerjXBQilY8YB0/n8Vbm7Tc7oSYWUHV42zYy/Ygci8m+kRO6DcMigpvM6PGBPNFmsPWswjW+jLURx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762341922; c=relaxed/simple;
	bh=WGjt1LZlkBB8w6gHVzXLXlbkP5HnD/BwtQ5i3ks0II4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FUP/muv4urBvHnU6io1I2iHhI2ovsTkzjRUNcH4Vsxk1Ec9HGmDT2dgnXyTS99EZIhaAQY/OUoprKKmD0MvF4xOT0MimZ2qVUT7T+mojh9aJHdOUBChwFWhttt5Nj8G6C1Ird/4ArKXL3LjCBdUYZA3E2I+HhKGThhvKO4pceY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FU8oo6YB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yraSf4DV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FU8oo6YB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yraSf4DV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FU8oo6YB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yraSf4DV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FU8oo6YB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yraSf4DV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id DEB5B211BA;
	Wed,  5 Nov 2025 11:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762341918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PP/vg4TETuUesnxpasg6ytdJ1cNcbiaaG4KK1fcuiIY=;
	b=FU8oo6YBT7CVji0/a6quURnUbwznLcDOExmxbfxdXFtYnSS8PShRbYT4ARqEpaDtFIicwJ
	JS0In1K9YI0YsGQrT1/ltls3nypEUSjkaN6YcRaxGDSX+0FikINZ1p91aY71KL9XKXicE0
	VQRXBBX0kYkMkdiiCajXUc0IGqgmhK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762341918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PP/vg4TETuUesnxpasg6ytdJ1cNcbiaaG4KK1fcuiIY=;
	b=yraSf4DVWYl/W5BFC3s/lbeuDEv7YTuyVTIQMD/jIKmWChOFdkfVF/XaOrgLfmRjUbXjDT
	55AGXH+HxCRUG3BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762341918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PP/vg4TETuUesnxpasg6ytdJ1cNcbiaaG4KK1fcuiIY=;
	b=FU8oo6YBT7CVji0/a6quURnUbwznLcDOExmxbfxdXFtYnSS8PShRbYT4ARqEpaDtFIicwJ
	JS0In1K9YI0YsGQrT1/ltls3nypEUSjkaN6YcRaxGDSX+0FikINZ1p91aY71KL9XKXicE0
	VQRXBBX0kYkMkdiiCajXUc0IGqgmhK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762341918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=PP/vg4TETuUesnxpasg6ytdJ1cNcbiaaG4KK1fcuiIY=;
	b=yraSf4DVWYl/W5BFC3s/lbeuDEv7YTuyVTIQMD/jIKmWChOFdkfVF/XaOrgLfmRjUbXjDT
	55AGXH+HxCRUG3BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2ADC132DD;
	Wed,  5 Nov 2025 11:25:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ShFKx40C2ncEQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Nov 2025 11:25:18 +0000
Message-ID: <1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz>
Date: Wed, 5 Nov 2025 12:25:18 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/23] slab: add sheaf support for batching kfree_rcu()
 operations
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>, Daniel Gomez <da.gomez@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Uladzislau Rezki <urezki@gmail.com>,
 Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org, linux-modules@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>
References: <20250910-slub-percpu-caches-v8-0-ca3099d8352c@suse.cz>
 <20250910-slub-percpu-caches-v8-4-ca3099d8352c@suse.cz>
 <0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org> <aQge2rmgRvd1JKxc@harry>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <aQge2rmgRvd1JKxc@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,gentwo.org,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org,kernel.org,suse.com,atomlin.com,intel.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

On 11/3/25 04:17, Harry Yoo wrote:
> On Fri, Oct 31, 2025 at 10:32:54PM +0100, Daniel Gomez wrote:
>> 
>> 
>> On 10/09/2025 10.01, Vlastimil Babka wrote:
>> > Extend the sheaf infrastructure for more efficient kfree_rcu() handling.
>> > For caches with sheaves, on each cpu maintain a rcu_free sheaf in
>> > addition to main and spare sheaves.
>> > 
>> > kfree_rcu() operations will try to put objects on this sheaf. Once full,
>> > the sheaf is detached and submitted to call_rcu() with a handler that
>> > will try to put it in the barn, or flush to slab pages using bulk free,
>> > when the barn is full. Then a new empty sheaf must be obtained to put
>> > more objects there.
>> > 
>> > It's possible that no free sheaves are available to use for a new
>> > rcu_free sheaf, and the allocation in kfree_rcu() context can only use
>> > GFP_NOWAIT and thus may fail. In that case, fall back to the existing
>> > kfree_rcu() implementation.
>> > 
>> > Expected advantages:
>> > - batching the kfree_rcu() operations, that could eventually replace the
>> >   existing batching
>> > - sheaves can be reused for allocations via barn instead of being
>> >   flushed to slabs, which is more efficient
>> >   - this includes cases where only some cpus are allowed to process rcu
>> >     callbacks (Android)
>> > 
>> > Possible disadvantage:
>> > - objects might be waiting for more than their grace period (it is
>> >   determined by the last object freed into the sheaf), increasing memory
>> >   usage - but the existing batching does that too.
>> > 
>> > Only implement this for CONFIG_KVFREE_RCU_BATCHED as the tiny
>> > implementation favors smaller memory footprint over performance.
>> > 
>> > Also for now skip the usage of rcu sheaf for CONFIG_PREEMPT_RT as the
>> > contexts where kfree_rcu() is called might not be compatible with taking
>> > a barn spinlock or a GFP_NOWAIT allocation of a new sheaf taking a
>> > spinlock - the current kfree_rcu() implementation avoids doing that.
>> > 
>> > Teach kvfree_rcu_barrier() to flush all rcu_free sheaves from all caches
>> > that have them. This is not a cheap operation, but the barrier usage is
>> > rare - currently kmem_cache_destroy() or on module unload.
>> > 
>> > Add CONFIG_SLUB_STATS counters free_rcu_sheaf and free_rcu_sheaf_fail to
>> > count how many kfree_rcu() used the rcu_free sheaf successfully and how
>> > many had to fall back to the existing implementation.
>> > 
>> > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>> 
>> Hi Vlastimil,
>> 
>> This patch increases kmod selftest (stress module loader) runtime by about
>> ~50-60%, from ~200s to ~300s total execution time. My tested kernel has
>> CONFIG_KVFREE_RCU_BATCHED enabled. Any idea or suggestions on what might be
>> causing this, or how to address it?
> 
> This is likely due to increased kvfree_rcu_barrier() during module unload.

Hm so there are actually two possible sources of this. One is that the
module creates some kmem_cache and calls kmem_cache_destroy() on it before
unloading. That does kvfree_rcu_barrier() which iterates all caches via
flush_all_rcu_sheaves(), but in this case it shouldn't need to - we could
have a weaker form of kvfree_rcu_barrier() that only guarantees flushing of
that single cache.

The other source is codetag_unload_module(), and I'm afraid it's this one as
it's hooked to evey module unload. Do you have CONFIG_CODE_TAGGING enabled?
Disabling it should help in this case, if you don't need memory allocation
profiling for that stress test. I think there's some space for improvement -
when compiled in but memalloc profiling never enabled during the uptime,
this could probably be skipped? Suren?

> It currently iterates over all CPUs x slab caches (that enabled sheaves,
> there should be only a few now) pair to make sure rcu sheaf is flushed
> by the time kvfree_rcu_barrier() returns.

Yeah, also it's done under slab_mutex. Is the stress test trying to unload
multiple modules in parallel? That would make things worse, although I'd
expect there's a lot serialization in this area already.

Unfortunately it will get worse with sheaves extended to all caches. We
could probably mark caches once they allocate their first rcu_free sheaf
(should not add visible overhead) and keep skipping those that never did.
> Just being curious, do you have any serious workload that depends on
> the performance of module unload?

