Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D782DEB64DA
	for <rcu@archiver.kernel.org>; Sat, 24 Jun 2023 07:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbjFXHJm (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Sat, 24 Jun 2023 03:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjFXHJm (ORCPT <rfc822;rcu@vger.kernel.org>);
        Sat, 24 Jun 2023 03:09:42 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5911F269F;
        Sat, 24 Jun 2023 00:09:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qp4wt6n50z4f3jYp;
        Sat, 24 Jun 2023 15:09:34 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgCXfQuslpZkLHMDLg--.8380S2;
        Sat, 24 Jun 2023 15:09:35 +0800 (CST)
Subject: Re: [PATCH v2 bpf-next 00/13] bpf: Introduce
 bpf_mem_cache_free_rcu().
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        daniel@iogearbox.net, andrii@kernel.org, void@manifault.com,
        paulmck@kernel.org
Cc:     tj@kernel.org, rcu@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, kernel-team@fb.com
References: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <a22325f8-b64c-6c46-4a84-72b418ec92de@huaweicloud.com>
Date:   Sat, 24 Jun 2023 15:09:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20230624031333.96597-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgCXfQuslpZkLHMDLg--.8380S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4rArWfXF48KFW3WFyUKFg_yoW3Grb_ZF
        WjgrW7Ww17KF1kWFWFkF4Ikw4kC39aq3Zag3yrWrn3JFyft393KFs8WFySya4fG3yxKFyD
        JaykXrZ0vrnFgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267
        AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80
        ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4
        AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IEe2xF
        o4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 6/24/2023 11:13 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> v1->v2:
> - Fixed race condition spotted by Hou. Patch 7.
>
> v1:
>
> Introduce bpf_mem_cache_free_rcu() that is similar to kfree_rcu except
> the objects will go through an additional RCU tasks trace grace period
> before being freed into slab.
>
> Patches 1-9 - a bunch of prep work
> Patch 10 - a patch from Paul that exports rcu_request_urgent_qs_task().
> Patch 12 - the main bpf_mem_cache_free_rcu patch.
> Patch 13 - use it in bpf_cpumask.
Should we allow mixed use of bpf_mem_cache_free() and bpf_mem_free_rcu()
? From the implementation, it seems the mixed use is allowed, right ? I
will try to hack htab to test such use case.

