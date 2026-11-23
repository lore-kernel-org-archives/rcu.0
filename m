Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426870;
	b=CoESHMhlOQlD7BU4pT6ZaQqCwXoDVOXV4qQ+dWXammBNJ/bqFOqE/9KXWCxGWpHE8ifX
	 Q812GsdjHyqtKej744jUcJZ40kRKNKtLMwrSaTobqNbCmsqFOhOBaW5G7TFwkZp0wd0LO
	 im3lJIBXYsAU8TkLs5aFaZVKRFpkXjaFpPBSvgEDJkPRX6yETHImzaec4+/JthVVS1xVp
	 jPSqO3ylNmnp/hG9sOGTZJH3Wjz7i7DnyNWrQCySS+z/bksZiYhsu9Qx3OrcDfyFsi6h1
	 nyyjXvJr1JM/mxEnOnNVbOa/sQWS1z7qs/zq7L6jljNoxBS0okrFzGS+unrsuPoam5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426870;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=klUf2CdqHQRXCM9LUthGI+m1p+fVvUp/IIQj44sT9IQ=;
	b=2lx5QeMKyZjhpBg2xrHH/f8NJTv1EcO4OKyAKUZTRCUTvF0W/0diPgtkd6RhtRTuaxzh
	 VMPP7X0lftMLuqeWvf4DUPc49/W7Qlrl/EPOiP40thFbqO/3UrcM3tzTAedWclIw3yDN0
	 T3AmpUVW/L7nMctEljh3jCtLy+JddRW7Z38gzPFXP4tug+lWZFQfRUCyPCT7EehL9UHkF
	 EcViQxgHe56hXjIKgvmgzDAZtRb7hlQ1WpqNIl5BOLQVopPh4X/9dalhLOFdyk0wdUlhd
	 t8/mVdqrzJkvg7gzkxWHq5po4xPahkko/EXZ/t2xtxjrKichKnJWPBJjUzAbUe2xM/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b="Rtp02d3/";
	arc=none smtp.remote-ip=115.124.30.124
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B2606A32C;
	Mon, 23 Nov 2026 09:41:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 368B2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Rtp02d3/
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795426860; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=klUf2CdqHQRXCM9LUthGI+m1p+fVvUp/IIQj44sT9IQ=;
	b=Rtp02d3/aSuZuhPF7fGO+np6FdZ0DoeOW5fdJ8Z48IAVoBOrhNAjWhwrWHAtgf2d0OzSnMhb/PXsTf6xEF4JgYOnlFlMauy8FBFSxbyce/6vVg04+4mnn/nVNwc6HwmiyFuFV76cXh4tZA7bvAM+dObikmS0/5Xz/llkX33zG1M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0XFGswNE_1795426856;
Received: from 30.74.144.153(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XFGswNE_1795426856 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 17:40:58 +0800
Message-ID: <100c33ee-be1c-4eeb-a94c-567cc0337c78@linux.alibaba.com>
Date: Mon, 23 Nov 2026 17:40:56 +0800
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
Subject: Re: [PATCH v3 2/5] mm/vmscan: move code to lru_gen_{add,del}_memcg()
To: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
 kasong@tencent.com, qi.zheng@linux.dev, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, baoquan.he@linux.dev, david@kernel.org, ljs@kernel.org,
 liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com,
 mhocko@suse.com, hannes@cmpxchg.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org
References: <20261116081403.216452-1-max.kellermann@ionos.com>
 <20261116081403.216452-3-max.kellermann@ionos.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261116081403.216452-3-max.kellermann@ionos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/16/26 4:14 PM, Max Kellermann wrote:
> Preparation for the following patch that adds tail caching.
> 
> For simplicity, hlist_nulls_del_init_rcu() is now always used, which
> is also valid during rotation, because the entry is immediately
> reinserted under `memcg_lru.lock`.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
