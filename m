Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C61721D3DA
	for <rcu@vger.kernel.org>; Wed, 26 Feb 2025 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740580504; cv=none; b=qu+Hc6EPcm8ZaqRUZa+iF/w+7+g4WYNYLyGQx60lxnPoIjNK3M9TghOp4DScBM2/dWXogj41SXsLZtJhtihgZ7i3gThLZXPSgybQL9fDtIeg8YNIdxqIfTkNyToALTeJ/obnKUkN21yfPB3mESpZbtW7J07RXc03KCiP+cPYgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740580504; c=relaxed/simple;
	bh=GqqQQsNA4ipMlgHM1b1lGDiKa6nAvwxuipFO3NvD51M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ks95LQu1ArfJKlpeHAbwnsyw0zSufbLRfIAUcOdgrT6sQwAAxJEEFRU9V52ZJaqQRK1EC/JYzjJh9d7/+ijz+vKcly6XW9/Z2D3u6npC1Ll2QnA17R6x8HvuHJd+pO9XaFR0pgJ1JnsbDlA4yoUT1G5ke9zbLJT4WLuunmvzPG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SnEImesK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rncUprZj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SnEImesK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rncUprZj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SnEImesK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rncUprZj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SnEImesK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rncUprZj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4E9241F388;
	Wed, 26 Feb 2025 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740580496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqqQQsNA4ipMlgHM1b1lGDiKa6nAvwxuipFO3NvD51M=;
	b=SnEImesKwOD2S5x1Ryp5YTodtXari0n6ncFypTf+CqYWjxPdddG1i07uvixKhKP5OQ8wfO
	xaIwoRSKhgbmr6dks/7aHQQKW7XrRApM4c3OEJK/zZ9XDVYhMskn0YHHu0KkZQHtfzFl2Y
	zy7kjIYXDQblXewHIRaBy7ugFaUP5iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740580496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqqQQsNA4ipMlgHM1b1lGDiKa6nAvwxuipFO3NvD51M=;
	b=rncUprZjfBAUyzR37zy5gRhswbxwek9mpX1A5H653qs5HHaiktGtNM113SJU6tyA+xn80D
	DikggDwysqOfkYAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SnEImesK;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rncUprZj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740580496; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqqQQsNA4ipMlgHM1b1lGDiKa6nAvwxuipFO3NvD51M=;
	b=SnEImesKwOD2S5x1Ryp5YTodtXari0n6ncFypTf+CqYWjxPdddG1i07uvixKhKP5OQ8wfO
	xaIwoRSKhgbmr6dks/7aHQQKW7XrRApM4c3OEJK/zZ9XDVYhMskn0YHHu0KkZQHtfzFl2Y
	zy7kjIYXDQblXewHIRaBy7ugFaUP5iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740580496;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GqqQQsNA4ipMlgHM1b1lGDiKa6nAvwxuipFO3NvD51M=;
	b=rncUprZjfBAUyzR37zy5gRhswbxwek9mpX1A5H653qs5HHaiktGtNM113SJU6tyA+xn80D
	DikggDwysqOfkYAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B29E1377F;
	Wed, 26 Feb 2025 14:34:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id elz1CZAmv2fWRgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 26 Feb 2025 14:34:56 +0000
Message-ID: <93f03922-3d3a-4204-89c1-90ea4e1fc217@suse.cz>
Date: Wed, 26 Feb 2025 15:36:39 +0100
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] mm, slab: call kvfree_rcu_barrier() from
 kmem_cache_destroy()
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Keith Busch <keith.busch@gmail.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Julia Lawall <Julia.Lawall@inria.fr>, Jakub Kicinski <kuba@kernel.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
 Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Jann Horn <jannh@google.com>, Mateusz Guzik <mjguzik@gmail.com>,
 linux-nvme@lists.infradead.org, leitao@debian.org
References: <20240807-b4-slab-kfree_rcu-destroy-v2-6-ea79102f428c@suse.cz>
 <Z7iqJtCjHKfo8Kho@kbusch-mbp> <2811463a-751f-4443-9125-02628dc315d9@suse.cz>
 <Z7xbrnP8kTQKYO6T@pc636> <ef97428b-f6e7-481e-b47e-375cc76653ad@suse.cz>
 <Z73p2lRwKagaoUnP@kbusch-mbp>
 <CAOSXXT6-oWjKPV1hzXa5Ra4SPQg0L_FvxCPM0Sh0Yk6X90h0Sw@mail.gmail.com>
 <Z74Av6tlSOqcfb-q@pc636> <Z74KHyGGMzkhx5f-@pc636>
 <8d7aabb2-2836-4c09-9fc7-8bde271e7f23@suse.cz> <Z78lpfLFvNxjoTNf@pc636>
From: Vlastimil Babka <vbabka@suse.cz>
Content-Language: en-US
In-Reply-To: <Z78lpfLFvNxjoTNf@pc636>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4E9241F388
X-Spam-Level: 
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,joelfernandes.org,joshtriplett.org,linux.com,google.com,goodmis.org,efficios.com,inria.fr,zx2c4.com,linux-foundation.org,linux.dev,kvack.org,vger.kernel.org,googlegroups.com,lists.infradead.org,debian.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLctujmen6hjyrx8fu4drawbuj)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 2/26/25 3:31 PM, Uladzislau Rezki wrote:
> On Wed, Feb 26, 2025 at 11:59:53AM +0100, Vlastimil Babka wrote:
>> On 2/25/25 7:21 PM, Uladzislau Rezki wrote:
>>>>
>>> WQ_MEM_RECLAIM-patch fixes this for me:
>>
>> Sounds good, can you send a formal patch then?
>>
> Do you mean both? Test case and fix? I can :)

Sure, but only the fix is for stable. Thanks!

