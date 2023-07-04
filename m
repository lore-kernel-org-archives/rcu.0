Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FDAEB64DC
	for <rcu@archiver.kernel.org>; Tue,  4 Jul 2023 01:14:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjGDBOB (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 3 Jul 2023 21:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjGDBOA (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 3 Jul 2023 21:14:00 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E26D184;
        Mon,  3 Jul 2023 18:13:59 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Qw4Yt2JLvz4f3q30;
        Tue,  4 Jul 2023 09:13:54 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDXPypQcqNkjCnEMQ--.2370S2;
        Tue, 04 Jul 2023 09:13:56 +0800 (CST)
Subject: Re: [PATCH bpf-next v8] selftests/bpf: Add benchmark for bpf memory
 allocator
To:     John Fastabend <john.fastabend@gmail.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com, Martin KaFai Lau <martin.lau@linux.dev>
References: <20230703141332.3319271-1-houtao@huaweicloud.com>
 <64a34309e42aa_652052084f@john.notmuch>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <47eb0f85-5950-bb15-079f-383a865e27c0@huaweicloud.com>
Date:   Tue, 4 Jul 2023 09:13:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <64a34309e42aa_652052084f@john.notmuch>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDXPypQcqNkjCnEMQ--.2370S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WFW7Aw4fJry3ZF45Ww1xXwb_yoW8ZFWUp3
        ykJa1fXr13Jrs7Gw18Aa4kJrW7Xr1fJw129r1rAa4Durs5Xws29r4xK3yUKry5uFyIkw42
        kayqvr12ka9rKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
        6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UWE__UUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 7/4/2023 5:52 AM, John Fastabend wrote:
> Hou Tao wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> The benchmark could be used to compare the performance of hash map
>> operations and the memory usage between different flavors of bpf memory
>> allocator (e.g., no bpf ma vs bpf ma vs reuse-after-gp bpf ma). It also
>> could be used to check the performance improvement or the memory saving
>> provided by optimization.
>>

SNIP
>> overwrite            per-prod-op: 191.92 ± 0.07k/s, avg mem: 1.23 ± 0.00MiB, peak mem: 1.49MiB
>> batch_add_batch_del  per-prod-op: 218.10 ± 0.25k/s, avg mem: 1.23 ± 0.00MiB, peak mem: 1.49MiB
>> add_del_on_diff_cpu  per-prod-op: 39.59 ± 0.41k/s, avg mem: 1.48 ± 0.11MiB, peak mem: 1.74MiB
>>
>> (3) normal bpf memory allocator
>>
>> overwrite            per-prod-op: 134.81 ± 0.22k/s, avg mem: 1.67 ± 0.12MiB, peak mem: 2.74MiB
>> batch_add_batch_del  per-prod-op: 90.44 ± 0.34k/s, avg mem: 2.27 ± 0.00MiB, peak mem: 2.74MiB
>> add_del_on_diff_cpu  per-prod-op: 28.20 ± 0.15k/s, avg mem: 1.73 ± 0.17MiB, peak mem: 2.06MiB
> Acked-by: John Fastabend <john.fastabend@gmail.com>
Thanks for the Ack.
>
>> +
>> +static error_t htab_mem_parse_arg(int key, char *arg, struct argp_state *state)
>> +{
>> +	switch (key) {
>> +	case ARG_VALUE_SIZE:
>> +		args.value_size = strtoul(arg, NULL, 10);
>> +		if (args.value_size > 4096) {
>> +			fprintf(stderr, "too big value size %u\n", args.value_size);
>> +			argp_usage(state);
>> +		}
>> +		break;
>> +	case ARG_USE_CASE:
>> +		args.use_case = strdup(arg);
> might be worth checking for null and returning an error? Only matters if we
> run from CI or something and then this looks like a flake.
Will fix. I also found an error reported from BPF CI llvm-16 build
procedure: "benchs/bench_htab_mem.c:45:27: error: initializer element is
not a compile-time constant". Will fix in v9.
>
>> +		break;
>> +	case ARG_PREALLOCATED:
>> +		args.preallocated = true;
>> +		break;
>> +	default:
>> +		return ARGP_ERR_UNKNOWN;
>> +	}
>> +
>> +	return 0;
>> +}

