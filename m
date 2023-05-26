Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49365C77B7A
	for <rcu@archiver.kernel.org>; Fri, 26 May 2023 19:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243791AbjEZTFj (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 26 May 2023 15:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243780AbjEZTFi (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 26 May 2023 15:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A677A13A
        for <rcu@vger.kernel.org>; Fri, 26 May 2023 12:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685127895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JhVelvQV+hPiU9wttpuIOnyHREBDtGBxkmx6tjkjhTE=;
        b=NdKwmXziBvb7XDQo3nXw2pqixluhKK6Ml3CWg1NTqcUSos30MBV/O3s3QNloADiNycT9Y1
        ieG+rstQNiFx9xKTGOBlSLW9VVG49AIfY/DpSoCe4+6JzAxmmjy6Q6MVwZz6SvjeFxUroO
        FK6BeMgAZkn8SQRNyTNvorcVK/ArE58=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-Hg5fBAoaPk-Bnyz3addx4A-1; Fri, 26 May 2023 15:04:53 -0400
X-MC-Unique: Hg5fBAoaPk-Bnyz3addx4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6A3198032E4;
        Fri, 26 May 2023 19:04:51 +0000 (UTC)
Received: from [10.22.32.123] (unknown [10.22.32.123])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE4B41121314;
        Fri, 26 May 2023 19:04:49 +0000 (UTC)
Message-ID: <2e44db55-61f1-ad3d-e9e1-a9409ffad31b@redhat.com>
Date:   Fri, 26 May 2023 15:04:49 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC][PATCH 1/2] locking: Introduce __cleanup__ based guards
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, paulmck@kernel.org,
        frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        jiangshanlai@gmail.com, qiang1.zhang@intel.com,
        rcu@vger.kernel.org, tj@kernel.org, tglx@linutronix.de
References: <20230526150549.250372621@infradead.org>
 <20230526151946.960406324@infradead.org>
 <cf20bbbc-c435-326d-f31a-86b1f4ce927a@redhat.com>
 <e63ca3f4-283a-05fb-d637-c7428d87c8f2@efficios.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <e63ca3f4-283a-05fb-d637-c7428d87c8f2@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 5/26/23 14:58, Mathieu Desnoyers wrote:
> On 5/26/23 14:49, Waiman Long wrote:
> [...]
>>
>> BTW, do we have a use case for double_lock_guard/double_lock_scope? I 
>> can envision a nested lock_scope inside a lock_scope, but taking 2 
>> auto locks of the same type at init time and then unlock them at exit 
>> just doesn't make sense to me.
>
> AFAIU taking both runqueue locks for source and destination runqueues 
> on migration is one use-case for double_lock_guard/scope.
>
I see. Thanks for the clarification. I forgot about that special case.

Cheers,
Longman

