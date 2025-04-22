Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFA280A5A
	for <rcu@vger.kernel.org>; Tue, 22 Apr 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745334171; cv=none; b=gyZ6z5GPMeUYwUApbpXetKUbbdxHogD/BbGZ+uhNC4pBKr9cVM7TorQPK8N6+LPN4tl5wbecvc+3u7htPPAB9sIrskNwy2DDE5MioN6SoHRjnXwoZXX6AqQ7qoH2o+hleNx3PKc+9K39byioSMf/0/i113elhr0jkBvnHNOW7Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745334171; c=relaxed/simple;
	bh=j+JWukjqNphYqGkQnFhlb5w6TEtOKm86BGwA4extLZw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LUqrNpvYq8aHRhwrVVF2ZANxK+3qjwE+aijjA4WyLsQnshSWMny3depvnjjziE2NMy+I54MCV76fUao7J7kHY0MWuWN6girEDWW/9YOILaVUuI0SZE//Fe0nas3NCXve9Rkfb8qKy8n2S465l2YLGQhlhfuu11uXEyyHZFyimXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hpHdW0Gk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+1kgr3uV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hpHdW0Gk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+1kgr3uV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hpHdW0Gk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+1kgr3uV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hpHdW0Gk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+1kgr3uV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 99E551F444;
	Tue, 22 Apr 2025 15:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745334167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kY+OgALyRhny2CxnYe6DTXTokYtMM0xdO8gEaNUZMJI=;
	b=hpHdW0GkV/2UTDtGzEzvbvO3JLr6a44MxbCqemu97UEoDJTETLcwW2fE4Lxp58h6sXPKjy
	fBIyS+R6LVElgrnTym4mcdKuuEWgMwoX+xrKNwUzgNWb3QoQUiGH/hUIfvQ/qa+I1icxsq
	oSPqQhgofRgLLDsSjqg2P0Pzx02Nui4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745334167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kY+OgALyRhny2CxnYe6DTXTokYtMM0xdO8gEaNUZMJI=;
	b=+1kgr3uVRJHJh1hBN70rJBL8XMLl1uMojeZ8WlPh2QYWy6Okd9G5cYp9i8tgiuCekrIqeE
	YZSFmPFzIBtTNnAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hpHdW0Gk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+1kgr3uV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745334167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kY+OgALyRhny2CxnYe6DTXTokYtMM0xdO8gEaNUZMJI=;
	b=hpHdW0GkV/2UTDtGzEzvbvO3JLr6a44MxbCqemu97UEoDJTETLcwW2fE4Lxp58h6sXPKjy
	fBIyS+R6LVElgrnTym4mcdKuuEWgMwoX+xrKNwUzgNWb3QoQUiGH/hUIfvQ/qa+I1icxsq
	oSPqQhgofRgLLDsSjqg2P0Pzx02Nui4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745334167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kY+OgALyRhny2CxnYe6DTXTokYtMM0xdO8gEaNUZMJI=;
	b=+1kgr3uVRJHJh1hBN70rJBL8XMLl1uMojeZ8WlPh2QYWy6Okd9G5cYp9i8tgiuCekrIqeE
	YZSFmPFzIBtTNnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8275E137CF;
	Tue, 22 Apr 2025 15:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 41+JH5evB2jWVgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 22 Apr 2025 15:02:47 +0000
Message-ID: <208e2b4a-cff5-432e-a330-74a8fc3a22cc@suse.cz>
Date: Tue, 22 Apr 2025 17:02:47 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/8] slab: add opt-in caching layer of percpu
 sheaves
Content-Language: en-US
To: Suren Baghdasaryan <surenb@google.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>, Harry Yoo <harry.yoo@oracle.com>,
 Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250317-slub-percpu-caches-v3-0-9d9884d8b643@suse.cz>
 <20250317-slub-percpu-caches-v3-2-9d9884d8b643@suse.cz>
 <CAJuCfpGNcb=TNQx5YB8EruG_Q61crLHCBJ9daC68r19b+S1fJA@mail.gmail.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAJuCfpGNcb=TNQx5YB8EruG_Q61crLHCBJ9daC68r19b+S1fJA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 99E551F444
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oracle.com,linux.com,google.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 4/10/25 21:51, Suren Baghdasaryan wrote:
>> +static void __pcs_flush_all_cpu(struct kmem_cache *s, unsigned int cpu)
>> +{
>> +       struct slub_percpu_sheaves *pcs;
>> +
>> +       pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>> +
>> +       /* The cpu is not executing anymore so we don't need pcs->lock */
>> +       sheaf_flush_unused(s, pcs->main);
> 
> You are flushing pcs->main but sheaf_flush_unused() will account that
> in SHEAF_FLUSH_OTHER instead of SHEAF_FLUSH_MAIN. Perhaps
> sheaf_flush_unused() needs a parameter to indicate which counter to be
> incremented.

Hm it's technically true, but it's a cpu hotremove operation so rather rare
and not performance sensitive and one could argue it's not a main sheaf (of
an active cpu) anymore. So I rather went with a comment than complicating
the code.

>> +       if (pcs->spare) {
>> +               sheaf_flush_unused(s, pcs->spare);
>> +               free_empty_sheaf(s, pcs->spare);
>> +               pcs->spare = NULL;
>> +       }
>> +}
>> +
>> +static void pcs_destroy(struct kmem_cache *s)
>> +{
>> +       int cpu;
>> +
>> +       for_each_possible_cpu(cpu) {
>> +               struct slub_percpu_sheaves *pcs;
>> +
>> +               pcs = per_cpu_ptr(s->cpu_sheaves, cpu);
>> +
>> +               /* can happen when unwinding failed create */
>> +               if (!pcs->main)
>> +                       continue;
>> +
>> +               WARN_ON(pcs->spare);
>> +
>> +               if (!WARN_ON(pcs->main->size)) {
> 
> If pcs->main->size > 0, shouldn't we flush pcs->main? I understand
> it's not a normal situation but I think something like this would be
> more correct:
> 
>               if (WARN_ON(pcs->main->size))
>                             sheaf_flush_unused(s, pcs->main);
>               free_empty_sheaf(s, pcs->main);
>               pcs->main = NULL;

Initially I agreed but then I realized we only reach this code when we
already found all slabs only containing free objects. So if we then find
some in sheaves it means something must have gone terribly wrong so trying
to flush can only make things worse. I've added a comment instead.

>> +                       free_empty_sheaf(s, pcs->main);
>> +                       pcs->main = NULL;
>> +               }
>> +       }
>> +
>> +       free_percpu(s->cpu_sheaves);
>> +       s->cpu_sheaves = NULL;
>> +}
>> +
>> +static struct slab_sheaf *barn_get_empty_sheaf(struct node_barn *barn)
>> +{
>> +       struct slab_sheaf *empty = NULL;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&barn->lock, flags);
>> +
>> +       if (barn->nr_empty) {
>> +               empty = list_first_entry(&barn->sheaves_empty,
>> +                                        struct slab_sheaf, barn_list);
>> +               list_del(&empty->barn_list);
>> +               barn->nr_empty--;
>> +       }
>> +
>> +       spin_unlock_irqrestore(&barn->lock, flags);
>> +
>> +       return empty;
>> +}
>> +
>> +static int barn_put_empty_sheaf(struct node_barn *barn,
>> +                               struct slab_sheaf *sheaf, bool ignore_limit)
> 
> This ignore_limit in barn_put_empty_sheaf()/barn_put_full_sheaf() is
> sticking out and really used only inside rcu_free_sheaf() in the next
> patch. Every time I saw the return value of these functions ignored I
> had to remind myself that they pass ignore_limit=true, so the function
> can't really fail. Maybe we could get rid of this flag and do trimming
> of barn lists inside rcu_free_sheaf() separately in one go? IIUC

Good suggestion, didn't realize the barn_put_() are only used in the
fallback-due-to-a-race-or-cpu-migration paths, so did as you suggested.

> because we ignore the limits in all other places, at the time of
> rcu_free_sheaf() we might end up with a barn having many more sheaves
> than the limit allows for, so trimming in bulk might be even more
> productive.

There are many caches with no rcu freeing happening so making
rcu_free_sheaf() a bulk trimming point could be insufficient. I'd just leave
it for now and hope that ignoring limits only due to races won't cause barns
to grow more than it could self-correct for just by further allocation/freeing.

>> +{
>> +       unsigned long flags;
>> +       int ret = 0;
>> +
>> +       spin_lock_irqsave(&barn->lock, flags);
>> +
>> +       if (!ignore_limit && barn->nr_empty >= MAX_EMPTY_SHEAVES) {
>> +               ret = -E2BIG;
>> +       } else {
>> +               list_add(&sheaf->barn_list, &barn->sheaves_empty);
>> +               barn->nr_empty++;
>> +       }
>> +
>> +       spin_unlock_irqrestore(&barn->lock, flags);
>> +       return ret;
>> +}
>> +
>> +static int barn_put_full_sheaf(struct node_barn *barn, struct slab_sheaf *sheaf,
>> +                              bool ignore_limit)
> 
> Can this function be called for partially populated sheaves or only
> full ones? I think rcu_free_sheaf() in the next patch might end up
> calling it for a partially populated sheaf.

It can, but the code handles not-really-full sheaves fine and it's easier to
allow them than try to be strict, there should be just a bit lower
efficiency in debug scenarios and that's fine. Adding a comment.

>> +{
>> +       unsigned long flags;
>> +       int ret = 0;
>> +
>> +       spin_lock_irqsave(&barn->lock, flags);
>> +
>> +       if (!ignore_limit && barn->nr_full >= MAX_FULL_SHEAVES) {
>> +               ret = -E2BIG;
>> +       } else {
>> +               list_add(&sheaf->barn_list, &barn->sheaves_full);
>> +               barn->nr_full++;
>> +       }
>> +
>> +       spin_unlock_irqrestore(&barn->lock, flags);
>> +       return ret;
>> +}
>> +
>> +/*
>> + * If a full sheaf is available, return it and put the supplied empty one to
>> + * barn. We ignore the limit on empty sheaves as the number of sheaves doesn't
>> + * change.
> 
> I'm unclear why we ignore the limit here but not in
> barn_replace_full_sheaf(). Maybe because full sheaves consume more
> memory?

Yes.

> But then why do we mostly pass ignore_limit=true when invoking
> barn_put_full_sheaf()?

Not anymore with your suggestion.

> Explanation of this limit logic needs to be
> clarified.
> 
>> +static __fastpath_inline
>> +unsigned int alloc_from_pcs_bulk(struct kmem_cache *s, size_t size, void **p)
>> +{
>> +       struct slub_percpu_sheaves *pcs;
>> +       struct slab_sheaf *main;
>> +       unsigned int allocated = 0;
>> +       unsigned int batch;
>> +
>> +next_batch:
>> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
>> +               return allocated;
>> +
>> +       pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +       if (unlikely(pcs->main->size == 0)) {
> 
> The above condition is unlikely only for the first batch. I think it's
> actually guaranteed on all consecutive batches once you do "goto
> next_batch", right?

Hm yes but perhaps bulk allocs larger than batch size are rare?

>> +static __fastpath_inline
>> +bool free_to_pcs(struct kmem_cache *s, void *object)
>> +{
>> +       struct slub_percpu_sheaves *pcs;
>> +
>> +restart:
>> +       if (!localtry_trylock(&s->cpu_sheaves->lock))
>> +               return false;
>> +
>> +       pcs = this_cpu_ptr(s->cpu_sheaves);
>> +
>> +       if (unlikely(pcs->main->size == s->sheaf_capacity)) {
>> +
>> +               struct slab_sheaf *empty;
>> +
>> +               if (!pcs->spare) {
>> +                       empty = barn_get_empty_sheaf(pcs->barn);
>> +                       if (empty) {
>> +                               pcs->spare = pcs->main;
>> +                               pcs->main = empty;
>> +                               goto do_free;
>> +                       }
>> +                       goto alloc_empty;
>> +               }
>> +
>> +               if (pcs->spare->size < s->sheaf_capacity) {
>> +                       stat(s, SHEAF_SWAP);
>> +                       swap(pcs->main, pcs->spare);
>> +                       goto do_free;
>> +               }
>> +
>> +               empty = barn_replace_full_sheaf(pcs->barn, pcs->main);
> 
> This function reads easier now but if barn_replace_full_sheaf() could
> ignore the MAX_FULL_SHEAVES and barn list trimming could be done
> later, it would simplify this function even further.

It could increase barn lock contention to put full sheaves there over limit
and then flush them afterwards so I think it's better to not do that.
Especially with "slab: determine barn status racily outside of lock".

> 
> nit: I think the section below would be more readable if structured
> with fail handling blocks at the end. Something like this:
> 
> next_batch:
>         if (!localtry_trylock(&s->cpu_sheaves->lock))
>                 goto fallback;
> 
>         pcs = this_cpu_ptr(s->cpu_sheaves);
> 
>         if (likely(pcs->main->size < s->sheaf_capacity))
>                 goto do_free;

Nice suggestion, did that. Thanks.

