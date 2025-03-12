Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672D71386DA
	for <rcu@vger.kernel.org>; Wed, 12 Mar 2025 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741803807; cv=none; b=I9XG7Y9xSi/5PqiAjZKffoD/RLlyQbWejlUe2FVKJRS+HiTsjMHwAJPZux/bzlrkY/7OdSBaIH+hVUjIhboEAWhVvwSnzBtBmYeoTcY3tExkakGB1Is57bw/nnZ1WAKdmHeUZicrYkrxk5vhKszFKeJFPVXY0sOSXlGB3kZCtZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741803807; c=relaxed/simple;
	bh=3PPQ+75E6TglwrFDfWrjRnFrp70iSJ8+4+dt1b50oJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VBpMOqVi9DC1gKiyjRW85JpERbBvJUfERYlQdKo0q4dXF/LqVb1BZCGa/c1ptbZYKp+tz10Nl3oKImkRp6R7UFcQRI+lPTQt5psohedALm+0tIOvktNvDIDU7JB/lquDzEWv2H8Sv4WpHpTBs3yqN7DHWcBjh9jFzXj1jpemPgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qlP7DBFH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AZy9K+qb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qlP7DBFH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AZy9K+qb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qlP7DBFH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AZy9K+qb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qlP7DBFH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AZy9K+qb"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 661032118B;
	Wed, 12 Mar 2025 18:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741803804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb0sF00gbdRjC6paR/sbSBa+p4aGat82DdohFtfUyYM=;
	b=qlP7DBFHl0sDx9NrdOob33f7SvEL1snKf2YvNik7fLHQ8DQ0863yPEz+zC5iXiCoobkL1O
	1soLve52Z80akP10NTdihQV18nZCIqI5hTSVfEsy3t4SVPjmCDgnMgNxBDRJUSeu7w2X9O
	4BcqtRZeaqe88BmeZ+Jm8P5/+EUMTas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741803804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb0sF00gbdRjC6paR/sbSBa+p4aGat82DdohFtfUyYM=;
	b=AZy9K+qboxjfGPjxdaktp+DS4Hm21tNw7zOUk87YaxQgl+xbVX5QVVmsherj3G0CRtF3S9
	JtZ2tnEDFS6cbiCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qlP7DBFH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AZy9K+qb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741803804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb0sF00gbdRjC6paR/sbSBa+p4aGat82DdohFtfUyYM=;
	b=qlP7DBFHl0sDx9NrdOob33f7SvEL1snKf2YvNik7fLHQ8DQ0863yPEz+zC5iXiCoobkL1O
	1soLve52Z80akP10NTdihQV18nZCIqI5hTSVfEsy3t4SVPjmCDgnMgNxBDRJUSeu7w2X9O
	4BcqtRZeaqe88BmeZ+Jm8P5/+EUMTas=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741803804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb0sF00gbdRjC6paR/sbSBa+p4aGat82DdohFtfUyYM=;
	b=AZy9K+qboxjfGPjxdaktp+DS4Hm21tNw7zOUk87YaxQgl+xbVX5QVVmsherj3G0CRtF3S9
	JtZ2tnEDFS6cbiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4A3421377F;
	Wed, 12 Mar 2025 18:23:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CwzEERzR0Wd1QQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 12 Mar 2025 18:23:24 +0000
Message-ID: <f495fc2a-00e1-4c76-a562-1e7f42a5fbea@suse.cz>
Date: Wed, 12 Mar 2025 19:23:24 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 07/10] slab: determine barn status racily outside
 of lock
Content-Language: en-US
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Christoph Lameter
 <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 maple-tree@lists.infradead.org
References: <20250214-slub-percpu-caches-v2-0-88592ee0966a@suse.cz>
 <20250214-slub-percpu-caches-v2-7-88592ee0966a@suse.cz>
 <Z72FPj_FzhCZpRsk@harry>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Z72FPj_FzhCZpRsk@harry>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 661032118B
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[google.com,oracle.com,linux.com,linux.dev,gmail.com,kvack.org,vger.kernel.org,lists.infradead.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 2/25/25 09:54, Harry Yoo wrote:
> On Fri, Feb 14, 2025 at 05:27:43PM +0100, Vlastimil Babka wrote:
>> The possibility of many barn operations is determined by the current
>> number of full or empty sheaves. Taking the barn->lock just to find out
>> that e.g. there are no empty sheaves results in unnecessary overhead and
>> lock contention. Thus perform these checks outside of the lock with a
>> data_race() annotated variable read and fail quickly without taking the
>> lock.
>> 
>> Checks for sheaf availability that racily succeed have to be obviously
>> repeated under the lock for correctness, but we can skip repeating
>> checks if there are too many sheaves on the given list as the limits
>> don't need to be strict.
>> 
>> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Looks good to me,
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> 
> in kmem_cache_return_sheaf:
>> if (!pcs->spare) {                                                      
>> 	pcs->spare = sheaf;                                             
>>	sheaf = NULL;                                                   
>> } else if (pcs->barn->nr_full >= MAX_FULL_SHEAVES) {                    
>>	/* racy check */                                                
>>	barn = pcs->barn;                                               
>>	keep = true;                                                    
>> }  
> 
> By the way this code also needs data_race()?

Right, will add, thanks.


