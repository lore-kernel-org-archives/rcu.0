Return-Path: <rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB81C433E0
	for <rcu@archiver.kernel.org>; Fri, 15 Jan 2021 17:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CAF02339E
	for <rcu@archiver.kernel.org>; Fri, 15 Jan 2021 17:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbhAORV5 (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Fri, 15 Jan 2021 12:21:57 -0500
Received: from mx.kolabnow.com ([95.128.36.40]:6678 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbhAORV4 (ORCPT <rfc822;rcu@vger.kernel.org>);
        Fri, 15 Jan 2021 12:21:56 -0500
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Jan 2021 12:21:55 EST
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTP id DD8671051;
        Fri, 15 Jan 2021 18:10:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        message-id:references:in-reply-to:subject:subject:from:from:date
        :date:content-transfer-encoding:content-type:content-type
        :mime-version:received:received:received; s=dkim20160331; t=
        1610730634; x=1612545035; bh=Wi+ong+4jO8mWnZAsRva1SBqZ/Ng1Q7Z1gy
        YqkN3uEU=; b=cp38JiubcCj6ZSzaiw0DKeTtRRF6/YDV6eRsLgVx9d/SiXJzx8/
        SoE6WE5XO9gBq3YzNybZ9vmX604fTb4ptdfKvCV5a0zADiT6/vlvvemAGZlZ/Olb
        M3pqHiK9x5Lbh0+sdSJ0OoAHVuYF7zAQRI2DnXH8VPFcTXgss1pBnssrpUVWkmVh
        7KHDQZXUzfOt2fFyK/VXjBAbxG1T054V1DcKrcfJU2MNZwehfufgNaQL3iy4+Ail
        iv9+5Q0s8EREvN/4nU0QDvklbul74R/zmK1py/jPCiOJ8VluZsVvRxQ+TGZgpLp9
        xWw0gmuqZlFdo9/vkS/gDtvJf13Jz0s7LfAP+jXAYJVQoihEiOmAexo7I/hSiJ43
        RBeKLXU1gCDfjysXvn7zicfzEPpCw/Iv1HKgF8Pb//TTR2SgXl7OzzRboIYPOVGV
        f+TtM7G2QOfbXGbA4SmPQ0DH9KmWo9+JDBY+Cu3PsF8PWsZuGEYmrkS9CLBcGG7/
        /L4wu3rcas59IkWQja1ykucUvNObhIwacAQlOKOwUVUt1U9L9845h1dUSsAdGc06
        9XNyKynNCW6ED9ljLqPdJnVcsPQZ7kgydn6xGSPtmoNDHwUQsEIs19Rgwm8BHlcT
        8jij1a0omaxpMpe/4d4zMjkbXqkjWPwOh/2tAEuSbbhVFkx4oSbkryZg=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out001.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uL4ZGzkPvEWG; Fri, 15 Jan 2021 18:10:34 +0100 (CET)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out001.mykolab.com (Postfix) with ESMTPS id B75EFA51;
        Fri, 15 Jan 2021 18:10:33 +0100 (CET)
Received: from int-subm001.mykolab.com (unknown [10.9.37.1])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 46839627;
        Fri, 15 Jan 2021 18:10:32 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 15 Jan 2021 18:10:26 +0100
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] drivers: Remove CONFIG_OPROFILE support
In-Reply-To: <08ecfc3e3fe1a01ad1e360e4afb7ffc8666a2676.1610622251.git.viresh.kumar@linaro.org>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <08ecfc3e3fe1a01ad1e360e4afb7ffc8666a2676.1610622251.git.viresh.kumar@linaro.org>
Message-ID: <399fd39170e14b6113c2c6f465d7ba2d@vaga.pv.it>
X-Sender: federico.vaga@vaga.pv.it
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On 2021-01-14 12:35, Viresh Kumar wrote:
> The "oprofile" user-space tools don't use the kernel OPROFILE support
> any more, and haven't in a long time. User-space has been converted to
> the perf interfaces.
> 
> Remove kernel's old oprofile support.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/RCU/NMI-RCU.rst                 |   3 +-
>  .../admin-guide/kernel-parameters.txt         |  14 -
>  Documentation/process/magic-number.rst        |   1 -
>  .../it_IT/process/magic-number.rst            |   1 -

Of course that's OK for the italian transation

-- 
Federico Vaga
