Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B537CC77B7A
	for <rcu@archiver.kernel.org>; Tue, 13 Jun 2023 07:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240400AbjFMHhV (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Jun 2023 03:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235218AbjFMHhR (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Jun 2023 03:37:17 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC501A5;
        Tue, 13 Jun 2023 00:37:11 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QgL3l09dFz4f3tPC;
        Tue, 13 Jun 2023 15:37:07 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7OdHIhkfcdhLg--.52188S7;
        Tue, 13 Jun 2023 15:37:07 +0800 (CST)
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
Subject: [PATCH bpf-next v6 3/5] selftests/bpf: Ensure that next_cpu() returns a valid CPU number
Date:   Tue, 13 Jun 2023 16:09:19 +0800
Message-Id: <20230613080921.1623219-4-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20230613080921.1623219-1-houtao@huaweicloud.com>
References: <20230613080921.1623219-1-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7OdHIhkfcdhLg--.52188S7
X-Coremail-Antispam: 1UD129KBjvJXoW7tr1DAFW3ur48ZryfJryrWFg_yoW8Ar18pa
        97Gw1qyFWftF17t3W8GF409FWSkwn7XrWrtr17Jry3ZFyxJrZ7XF1xKFWrJFsxu39Yqr1f
        Z397try5u3W8Jw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
        vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
        w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
        0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1c4S7UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

From: Hou Tao <houtao1@huawei.com>

When using option -a without --prod-affinity or --cons-affinity, if the
number of producers and consumers is greater than the number of online
CPUs, the benchmark will fail to run as shown below:

  $ getconf _NPROCESSORS_ONLN
  8
  $ ./bench bpf-loop -a -p9
  Setting up benchmark 'bpf-loop'...
  setting affinity to CPU #8 failed: -22

Fix it by returning the remainder of next_cpu divided by the number of
online CPUs in next_cpu().

Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 tools/testing/selftests/bpf/bench.c | 3 ++-
 tools/testing/selftests/bpf/bench.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 0b5d2b5303c9..56f1c166a57b 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -469,7 +469,7 @@ static int next_cpu(struct cpu_set *cpu_set)
 		exit(1);
 	}
 
-	return cpu_set->next_cpu++;
+	return cpu_set->next_cpu++ % env.nr_cpus;
 }
 
 static struct bench_state {
@@ -659,6 +659,7 @@ static void collect_measurements(long delta_ns) {
 
 int main(int argc, char **argv)
 {
+	env.nr_cpus = get_nprocs();
 	parse_cmdline_args_init(argc, argv);
 
 	if (env.list) {
diff --git a/tools/testing/selftests/bpf/bench.h b/tools/testing/selftests/bpf/bench.h
index 402729c6a3ac..7ff32be3d730 100644
--- a/tools/testing/selftests/bpf/bench.h
+++ b/tools/testing/selftests/bpf/bench.h
@@ -27,6 +27,7 @@ struct env {
 	bool quiet;
 	int consumer_cnt;
 	int producer_cnt;
+	int nr_cpus;
 	struct cpu_set prod_cpus;
 	struct cpu_set cons_cpus;
 };
-- 
2.29.2

