Return-Path: <SRS0=0MOJ=WJ=vger.kernel.org=rcu-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BCDC433FF
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 08:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA04720679
	for <rcu@archiver.kernel.org>; Tue, 13 Aug 2019 08:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565685187;
	bh=unpmMBhs4Ryw1cerppIFvtapYPS35xYcBeAoCDolA6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i0P2dLRhrp+34rEJa8qvQFcTp41Nd1BfPiucQ/i14v76jsfuY5gL9lq86P5DoVgbp
	 HV1rlGs52wm5xtpY+TU3rkRlfcJR1HDb1SMmEqHykAxDwYy8oCOHwlq82PsrAseQev
	 /nyXtXbwt0Q0lNiAO1HxOKz4jYwjhC4vULr+LhtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbfHMIdH (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Tue, 13 Aug 2019 04:33:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727769AbfHMIdH (ORCPT <rfc822;rcu@vger.kernel.org>);
        Tue, 13 Aug 2019 04:33:07 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A41620663;
        Tue, 13 Aug 2019 08:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565685186;
        bh=unpmMBhs4Ryw1cerppIFvtapYPS35xYcBeAoCDolA6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WqrCGZiwPT5XJfLodebKxXSJPKmci2x2fwZGH36KLg7TF4/ErOQsgXAxSmwpQMb4W
         /8CtB7mhub9VGftPo7SpT8b1cK2f5l/j1A4H7LKGYd5eKMldbAKdzQSpiHANqtgiYf
         PYe/ar6YQ1VZMDRfqa1J+cpLiLimW4AePBBWOokU=
Date:   Tue, 13 Aug 2019 09:32:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     akpm@linux-foundation.org, sedat.dilek@gmail.com,
        jpoimboe@redhat.com, yhs@fb.com, miguel.ojeda.sandonis@gmail.com,
        clang-built-linux@googlegroups.com,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hans Liljestrand <ishkamiel@gmail.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        David Windsor <dwindsor@gmail.com>,
        Marc Zyngier <maz@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Dou Liyang <douliyangs@gmail.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-sparse@vger.kernel.org, rcu@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 14/16] include/linux: prefer __section from
 compiler_attributes.h
Message-ID: <20190813083257.nnsxf5khnqagl46s@willie-the-truck>
References: <20190812215052.71840-1-ndesaulniers@google.com>
 <20190812215052.71840-14-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812215052.71840-14-ndesaulniers@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: rcu-owner@vger.kernel.org
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Mon, Aug 12, 2019 at 02:50:47PM -0700, Nick Desaulniers wrote:
> Link: https://github.com/ClangBuiltLinux/linux/issues/619
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---

-ENOCOMMITMESSAGE

Otherwise, patch looks good to me.

Will
