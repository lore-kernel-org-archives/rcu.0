Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 879C0C77B7A
	for <rcu@archiver.kernel.org>; Mon, 12 Jun 2023 00:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbjFLA4p (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sun, 11 Jun 2023 20:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFLA4o (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sun, 11 Jun 2023 20:56:44 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904BD1BD;
        Sun, 11 Jun 2023 17:56:43 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4QfYD62L0Yz4f3mJ6;
        Mon, 12 Jun 2023 08:56:38 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP1 (Coremail) with SMTP id cCh0CgDXMRxEbYZklBBwKw--.51708S2;
        Mon, 12 Jun 2023 08:56:40 +0800 (CST)
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add benchmark for bpf memory
 allocator
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        Yonghong Song <yhs@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Hou Tao <houtao1@huawei.com>
References: <20230609024030.2585058-1-houtao@huaweicloud.com>
 <20230609031907.5yt7pnnynrawjzht@MacBook-Pro-8.local>
 <7e1ed3f0-f6b1-a022-d7c5-055a80deb606@huaweicloud.com>
 <CAADnVQK-e9Y0gNyDUu6kZ4K9P0UXLdkwhvWT_iEhxJeB5JSAyg@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <4fc55e64-9ed0-1e12-412c-a39b838abff7@huaweicloud.com>
Date:   Mon, 12 Jun 2023 08:56:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQK-e9Y0gNyDUu6kZ4K9P0UXLdkwhvWT_iEhxJeB5JSAyg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: cCh0CgDXMRxEbYZklBBwKw--.51708S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFyrKF1fKrW8uryfJrW7twb_yoW3CFX_Zr
        1vvr95Aw1UKwn8tF4qqr45uFy8ZF1YvF17AFyUArWIqr1Fq3Z0krWqkryUX34kKF4ayr9I
        ga4qv3srtFZxXjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbIxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 6/10/2023 12:12 AM, Alexei Starovoitov wrote:
> On Thu, Jun 8, 2023 at 11:32 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>>> +                    --producers=8 --prod-affinity=0-7 "$@")"
>>> -a -p 8 should just work.
>>> No need to pick specific cpus.
>> No. For VM with only 8 CPUs, the affinity of the first producer will be
>> CPU 1 and the affinity of the last producer will be CPU 8, so the
>> benchmark will fail to run. But I think I can fix it, so the affinity of
>> the last producer will be 0 instead.
> Right. Noticed that too.
> That should probably be a separate patch to fix this cpu assignment
> issue in bench for all benchs.
>
> Andrii,
> when you wrote it did you really mean to start assigning cpus from 1
> or that was just an oversight?
I think the reason is that the CPU affinity of the consumer is CPU 0.

