Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0374828C847
	for <rcu@vger.kernel.org>; Mon, 15 Sep 2025 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757949738; cv=none; b=M3PSs10/afFW83OA9jBYNTmQpsFVyiPBOfK/A1Q5EL5Nh6tLYIIlMkNWQSuA1PLb8t13l4TGpnpmuvgDalb81pEklljvrgYvecwm3pVUbT5AV0oAhydq6TYgIYIuF/wJmM1iBU9sPF0OwVtiJ9WYcr4f+6knpz5Pk9iHdSgtWx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757949738; c=relaxed/simple;
	bh=lAKXHovJuHC8HpNPv+BhEiC+s9EmD83CVYU6Wj+mStM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u4T1n9OraO1byK3B5932ncRFJZQBwQF+0ROXrcmBvO/h66gRvJYfmXHTl878DUmbDgL6I+Raf/GJT7+l50+L5yM4QQzp+Wx2UeCTfgGKA39DoBaafR0i+QWIRBmGn3tafISPiw8/qwhDDdb6M+N70EwEsfdsJk4UQS0ZeobMdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWbu/dbr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LlAYqGyw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MWbu/dbr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LlAYqGyw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWbu/dbr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LlAYqGyw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MWbu/dbr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LlAYqGyw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 539A21FB9D;
	Mon, 15 Sep 2025 15:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757949735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g++Ng2aE8L4wMW36WPMF8LdbnzmEpxKB+UrWXNi4yxc=;
	b=MWbu/dbr53BEeG65rCxERx1bCI6Mt53RMzj7/Ba3VW692rYCwQTW1LRY2Q8S/qfGI7/CYW
	zIHsqlM7kn89+9ZgfzxT4yS0d7G1lggT5yJC3RNHLDWRyj/7iuhHt8OBb8YjSGbxhuNfm9
	O11u7LcVjwBqD6Bk7ywsXn8ft9vosbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757949735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g++Ng2aE8L4wMW36WPMF8LdbnzmEpxKB+UrWXNi4yxc=;
	b=LlAYqGywt7Iynbk0+KZIVJIMtpL7nWaw5KXrjeU0wzEZpCbyAg/C2HP92oPXYJVilpOk7j
	o1yISor1tV3MjSCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1757949735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g++Ng2aE8L4wMW36WPMF8LdbnzmEpxKB+UrWXNi4yxc=;
	b=MWbu/dbr53BEeG65rCxERx1bCI6Mt53RMzj7/Ba3VW692rYCwQTW1LRY2Q8S/qfGI7/CYW
	zIHsqlM7kn89+9ZgfzxT4yS0d7G1lggT5yJC3RNHLDWRyj/7iuhHt8OBb8YjSGbxhuNfm9
	O11u7LcVjwBqD6Bk7ywsXn8ft9vosbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1757949735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g++Ng2aE8L4wMW36WPMF8LdbnzmEpxKB+UrWXNi4yxc=;
	b=LlAYqGywt7Iynbk0+KZIVJIMtpL7nWaw5KXrjeU0wzEZpCbyAg/C2HP92oPXYJVilpOk7j
	o1yISor1tV3MjSCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 374891368D;
	Mon, 15 Sep 2025 15:22:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MyA0DScvyGg6dAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 15 Sep 2025 15:22:15 +0000
Message-ID: <d1ef1cbb-c18d-4da6-b56b-342e86dca525@suse.cz>
Date: Mon, 15 Sep 2025 17:22:14 +0200
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Benchmarking [PATCH v5 00/14] SLUB percpu sheaves
To: paulmck@kernel.org, Jan Engelhardt <ej@inai.de>
Cc: Sudarsan Mahendran <sudarsanm@google.com>, Liam.Howlett@oracle.com,
 cl@gentwo.org, harry.yoo@oracle.com, howlett@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 maple-tree@lists.infradead.org, rcu@vger.kernel.org, rientjes@google.com,
 roman.gushchin@linux.dev, surenb@google.com, urezki@gmail.com
References: <20250723-slub-percpu-caches-v5-0-b792cd830f5d@suse.cz>
 <20250913000935.1021068-1-sudarsanm@google.com>
 <qs3967pq-4nq7-67pq-2025-r7259o0s52p4@vanv.qr>
 <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <f5792407-d2b9-42b3-bc85-ed14eac945ec@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,gentwo.org,gmail.com,vger.kernel.org,kvack.org,lists.infradead.org,linux.dev];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 9/15/25 14:13, Paul E. McKenney wrote:
> On Mon, Sep 15, 2025 at 09:51:25AM +0200, Jan Engelhardt wrote:
>> 
>> On Saturday 2025-09-13 02:09, Sudarsan Mahendran wrote:
>> >
>> >Summary of the results:

In any case, thanks a lot for the results!

>> >- Significant change (meaning >10% difference
>> >  between base and experiment) on will-it-scale
>> >  tests in AMD.
>> >
>> >Summary of AMD will-it-scale test changes:
>> >
>> >Number of runs : 15
>> >Direction      : + is good
>> 
>> If STDDEV grows more than mean, there is more jitter,
>> which is not "good".
> 
> This is true.  On the other hand, the mean grew way more in absolute
> terms than did STDDEV.  So might this be a reasonable tradeoff?

Also I'd point out that MIN of TEST is better than MAX of BASE, which means
there's always an improvement for this config. So jitter here means it's
changing between better and more better :) and not between worse and (more)
better.

The annoying part of course is that for other configs it's consistently the
opposite.

> Of course, if adjustments can be made to keep the increase in mean while
> keeping STDDEV low, that would of course be even better.
> 
> 							Thanx, Paul
> 
>> >|            | MIN        | MAX        | MEAN       | MEDIAN     | STDDEV     |
>> >|:-----------|:-----------|:-----------|:-----------|:-----------|:-----------|
>> >| brk1_8_processes
>> >| BASE       | 7,667,220  | 7,705,767  | 7,682,782  | 7,676,211  | 12,733     |
>> >| TEST       | 9,477,395  | 10,053,058 | 9,878,753  | 9,959,360  | 182,014    |
>> >| %          | +23.61%    | +30.46%    | +28.58%    | +29.74%    | +1,329.46% |
>> >
>> >| mmap2_256_processes
>> >| BASE       | 7,483,929  | 7,532,461  | 7,491,876  | 7,489,398  | 11,134     |
>> >| TEST       | 11,580,023 | 16,508,551 | 15,337,145 | 15,943,608 | 1,489,489  |
>> >| %          | +54.73%    | +119.17%   | +104.72%   | +112.88%   | +13,276.75%|
>> 

