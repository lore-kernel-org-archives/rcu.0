Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E64EB64DB
	for <rcu@archiver.kernel.org>; Mon, 19 Jun 2023 14:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjFSOA1 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 19 Jun 2023 10:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjFSOA0 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 19 Jun 2023 10:00:26 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2206610F;
        Mon, 19 Jun 2023 07:00:25 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QlBH701rCz4f3pP3;
        Mon, 19 Jun 2023 22:00:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgCH77JtX5BkiIFAMA--.58229S4;
        Mon, 19 Jun 2023 22:00:15 +0800 (CST)
From:   Hou Tao <houtao@huaweicloud.com>
To:     bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
        Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        houtao1@huawei.com
Subject: [RFC PATCH bpf-next v5 0/2] Handle immediate reuse in bpf memory allocator
Date:   Mon, 19 Jun 2023 22:32:29 +0800
Message-Id: <20230619143231.222536-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77JtX5BkiIFAMA--.58229S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tw1UGFW5Zr4DArWDuw1kGrg_yoW8tw1Dpr
        WfCw43Gr45XrsFywn7Jr17A3WrWws5Kw17WFsI934ru3yrXry7uFs29F4rZFy3WFWxKa4Y
        qFn2yrnYgas5X3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UZ18PUUUUU=
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

Hi,

V5 incorporates suggestions from Alexei and Paul (Big thanks for that).
The main changes includes:
*) Use per-cpu list for reusable list and freeing list to reduce lock
   contention and retain numa-ware attribute
*) Use multiple RCU callback for reuse as v3 did
*) Use rcu_momentary_dyntick_idle() to reduce the peak memory footprint

Please see individual patches for more details. As ususal comments and
suggestions are always welcome.

Change Log:
v5:
  * remove prepare_reuse_head and prepare_reuse_tail
  * use 32 as both low_watermark and high_watermark
  * use per-cpu list for reusable list and freeing list
  * use multiple RCU callbacks to do object reuse
  * remove *_tail for all lists
  * use rcu_momentary_dyntick_idle() to shorten RCU grace period

v4: https://lore.kernel.org/bpf/20230606035310.4026145-1-houtao@huaweicloud.com/
 * no kworker (Alexei)
 * Use a global reusable list in bpf memory allocator (Alexei)
 * Remove BPF_MA_FREE_AFTER_RCU_GP flag and do reuse-after-rcu-gp
   defaultly in bpf memory allocator (Alexei)
 * add benchmark results from map_perf_test (Alexei)

v3: https://lore.kernel.org/bpf/20230429101215.111262-1-houtao@huaweicloud.com/
 * add BPF_MA_FREE_AFTER_RCU_GP bpf memory allocator
 * Update htab memory benchmark
   * move the benchmark patch to the last patch
   * remove array and useless bpf_map_lookup_elem(&array, ...) in bpf
     programs
   * add synchronization between addition CPU and deletion CPU for
     add_del_on_diff_cpu case to prevent unnecessary loop
   * add the benchmark result for "extra call_rcu + bpf ma"

v2: https://lore.kernel.org/bpf/20230408141846.1878768-1-houtao@huaweicloud.com/
 * add a benchmark for bpf memory allocator to compare between different
   flavor of bpf memory allocator.
 * implement BPF_MA_REUSE_AFTER_RCU_GP for bpf memory allocator.

v1: https://lore.kernel.org/bpf/20221230041151.1231169-1-houtao@huaweicloud.com/
 
Hou Tao (2):
  bpf: Only reuse after one RCU GP in bpf memory allocator
  bpf: Call rcu_momentary_dyntick_idle() in task work periodically

 kernel/bpf/memalloc.c | 371 ++++++++++++++++++++++++++++--------------
 1 file changed, 250 insertions(+), 121 deletions(-)

-- 
2.29.2

