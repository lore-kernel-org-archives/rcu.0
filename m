Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5A1C352A1
	for <rcu@archiver.kernel.org>; Wed,  7 Dec 2022 02:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLGCZB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 6 Dec 2022 21:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLGCY7 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 6 Dec 2022 21:24:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A54A4C263;
        Tue,  6 Dec 2022 18:24:58 -0800 (PST)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRgxW1GXSzXdYY;
        Wed,  7 Dec 2022 10:20:47 +0800 (CST)
Received: from [10.174.176.117] (10.174.176.117) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 10:24:56 +0800
Subject: Re: [PATCH bpf-next 2/2] bpf: Skip rcu_barrier() if
 rcu_trace_implies_rcu_gp() is true
To:     Hou Tao <houtao@huaweicloud.com>, <bpf@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, <rcu@vger.kernel.org>
CC:     Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "houtao1@huawei.com" <houtao1@huawei.com>
References: <20221206042946.686847-1-houtao@huaweicloud.com>
 <20221206042946.686847-3-houtao@huaweicloud.com>
From:   Hou Tao <houtao1@huawei.com>
Message-ID: <2eac2a50-40bd-3430-039f-58947d7c7af5@huawei.com>
Date:   Wed, 7 Dec 2022 10:24:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20221206042946.686847-3-houtao@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.176.117]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Forget to cc Paul and RCU maillist for more comments.

On 12/6/2022 12:29 PM, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
>
> If there are pending rcu callback, free_mem_alloc() will use
> rcu_barrier_tasks_trace() and rcu_barrier() to wait for the pending
> __free_rcu_tasks_trace() and __free_rcu() callback.
>
> If rcu_trace_implies_rcu_gp() is true, there will be no pending
> __free_rcu(), so it will be OK to skip rcu_barrier() as well.
>
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/memalloc.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
> index 7daf147bc8f6..d43991fafc4f 100644
> --- a/kernel/bpf/memalloc.c
> +++ b/kernel/bpf/memalloc.c
> @@ -464,9 +464,17 @@ static void free_mem_alloc(struct bpf_mem_alloc *ma)
>  {
>  	/* waiting_for_gp lists was drained, but __free_rcu might
>  	 * still execute. Wait for it now before we freeing percpu caches.
> +	 *
> +	 * rcu_barrier_tasks_trace() doesn't imply synchronize_rcu_tasks_trace(),
> +	 * but rcu_barrier_tasks_trace() and rcu_barrier() below are only used
> +	 * to wait for the pending __free_rcu_tasks_trace() and __free_rcu(),
> +	 * so if call_rcu(head, __free_rcu) is skipped due to
> +	 * rcu_trace_implies_rcu_gp(), it will be OK to skip rcu_barrier() by
> +	 * using rcu_trace_implies_rcu_gp() as well.
>  	 */
>  	rcu_barrier_tasks_trace();
> -	rcu_barrier();
> +	if (!rcu_trace_implies_rcu_gp())
> +		rcu_barrier();
>  	free_mem_alloc_no_barrier(ma);
>  }
>  

