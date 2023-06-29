Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0265EB64D7
	for <rcu@archiver.kernel.org>; Thu, 29 Jun 2023 02:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbjF2C2t (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Wed, 28 Jun 2023 22:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjF2C2t (ORCPT <rfc822;rcu@vger.kernel.org>);
        Wed, 28 Jun 2023 22:28:49 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FF81BE4;
        Wed, 28 Jun 2023 19:28:48 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs2SX4dQZz4f4F3C;
        Thu, 29 Jun 2023 10:28:44 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
        by APP3 (Coremail) with SMTP id _Ch0CgDHuRda7Jxk9ehcLw--.33191S2;
        Thu, 29 Jun 2023 10:28:45 +0800 (CST)
Subject: Re: [PATCH bpf-next v7 1/2] selftests/bpf: Add min() and max() macros
 in bpf_util.h
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
References: <20230628115910.3817966-1-houtao@huaweicloud.com>
 <20230628115910.3817966-2-houtao@huaweicloud.com>
 <CAADnVQ+yg5iP59Y1oTsZmM6A2orOY=JNZME+m=TgJpOKwYbj_Q@mail.gmail.com>
From:   Hou Tao <houtao@huaweicloud.com>
Message-ID: <91b90b24-3bdf-cbdc-dd59-d8b78b1af368@huaweicloud.com>
Date:   Thu, 29 Jun 2023 10:28:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAADnVQ+yg5iP59Y1oTsZmM6A2orOY=JNZME+m=TgJpOKwYbj_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: _Ch0CgDHuRda7Jxk9ehcLw--.33191S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JF4DXFy3tw1rKr4fZw1xuFg_yoWDKFXEqr
        4Fyr97AFWkCFyqv3WUCas3uFW8GayrWrsrJr45try3CF1DXa1rJFs5uryYvF9IgayDGFW3
        JFsYvFZxJr4YqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbI8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
        GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6Fyj6rWUJwCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        xUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

Hi,

On 6/29/2023 2:02 AM, Alexei Starovoitov wrote:
> On Wed, Jun 28, 2023 at 4:41 AM Hou Tao <houtao@huaweicloud.com> wrote:
>> From: Hou Tao <houtao1@huawei.com>
>>
>> max() will be used by the following htab-mem benchmark patch.
>>
>> Signed-off-by: Hou Tao <houtao1@huawei.com>
>> ---
>>  tools/testing/selftests/bpf/bpf_util.h | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_util.h b/tools/testing/selftests/bpf/bpf_util.h
>> index 10587a29b967..e87e9f8c13a7 100644
>> --- a/tools/testing/selftests/bpf/bpf_util.h
>> +++ b/tools/testing/selftests/bpf/bpf_util.h
>> @@ -59,4 +59,11 @@ static inline void bpf_strlcpy(char *dst, const char *src, size_t sz)
>>         (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>>  #endif
>>
>> +#ifndef min
>> +#define min(x, y) ((x) < (y) ? (x) : (y))
>> +#endif
>> +#ifndef max
>> +#define max(x, y) ((x) < (y) ? (y) : (x))
>> +#endif
> That's for user space only?
> Just use the standard MIN/MAX macros.
> .
Yes. Will update and remove this prepare patch.

