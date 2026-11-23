Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428553;
	b=Uzyi02jUo4LIhNqL/eqWgAbPj/NVeWfmd4ZzS3CJLlxaKeLn4+4YDA0pPjOiZvfXzuA0
	 x56/QtDV7jY7qVx0tGRk12ggDyliT3q2Y52Eo21DQkSpZDXY2NzcQ0YE99aeTZ38Ybj+r
	 I+at3IQ0FgayTkJ5CnEzcCKcHL0mNJtJ+BjCUk0+4yvXLCUJwNH3EoF7Aquc1uSzOZh2P
	 daGdH+PybzfYaRonuPml1o1Nt/dc87ebiMLvClC2rj6Ubhs7cy/DFjZFmQjEHkgG+uQPk
	 LTLVuqKazwvuXt+eupvC1eSxjVm9S1o1KC64mA2I515NL2Bhf+nxxtySGX6V4yQQZJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428553;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pryCjk4CWyRrgAZYc/zoRA3NaYdrmsP+3BUItR4T6Yg=;
	b=OfrvG3ljcCgQzwvU1M/HE6J7wRKOTgkSnxT8yyP62giVGI3ApJQwbvUiUk4NW4S1CWi1
	 twz5Dfy2/yz3N6qNm98xX2kQZrf0cAKlGx4rc9x3imb+iSfe6pl1T0IluGzCNhz7D5N08
	 Dvt5ssux3IJ+hW6vMMr4lSrHrHrGDHypkOGHC2Iv2QQX5D42JSUrPHN3v9wy6J9oJ9HET
	 LTtOICaokhzXgqF+VvMH/hss+Rm+ZOGKyyUFthWi2vjq+cPubwIZ7CkCrQRenhIzAXTUl
	 e060csThpF7jnIGr+aLC4EczYUkkwjEXRuv5DolE/R86CQUfFWv6wfmLgFExmUKLuwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HkvqPXMt;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C88606A31A;
	Mon, 23 Nov 2026 10:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63C88606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HkvqPXMt
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795428550; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pryCjk4CWyRrgAZYc/zoRA3NaYdrmsP+3BUItR4T6Yg=;
	b=HkvqPXMt/TcWxgnm42naX/hug0BCFXDRpnQLfggBZuYf/tTmaAsbOnw+8sAOHLTFfv60t+Obr2lEKOlXqWpl1Qo2BOmeCjMIgCx9wrwrkU8EyZkgtZ0EtG7jqq7x6Q/isO0pbWOU3Tm93U08nb+0W7aN3EKuw0A5F9ls0LUbyCI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XFH23DP_1795428547;
Received: from 30.74.144.153(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XFH23DP_1795428547 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 18:09:08 +0800
Message-ID: <cc47e669-a662-4d80-950e-d44bb4c311a3@linux.alibaba.com>
Date: Mon, 23 Nov 2026 18:09:07 +0800
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Post: <mailto:rcu@vger.kernel.org>
List-Help: <mailto:rcu+help@vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
List-Owner: <mailto:rcu+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] mm/mglru: reschedule between memcg reclaim
 attempts
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, baoquan.he@linux.dev, david@kernel.org, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20261116081403.216452-1-max.kellermann@ionos.com>
 <20261116081403.216452-6-max.kellermann@ionos.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261116081403.216452-6-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/16/26 4:14 PM, Max Kellermann wrote:
> shrink_one() can return immediately for empty or protected memcgs, and
> try_to_shrink_lruvec() can break out before reaching its
> cond_resched().  A scan through many memcgs can repeatedly rotate
> entries without giving other runnable tasks a scheduling opportunity.
> 
> Call cond_resched_tasks_rcu_qs() (as the existing shrink_lruvec() loop
> does) after shrink_one(), while the memcg reference still pins the
> cursor and before reacquiring the RCU read lock.  Also call it between
> bins and nulls-marker retries, covering scans that skip every entry.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
