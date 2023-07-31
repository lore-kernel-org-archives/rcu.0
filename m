Return-Path: <rcu-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4AEC00528
	for <rcu@archiver.kernel.org>; Mon, 31 Jul 2023 12:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjGaMID (ORCPT <rfc822;rcu@archiver.kernel.org>);
        Mon, 31 Jul 2023 08:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjGaMIB (ORCPT <rfc822;rcu@vger.kernel.org>);
        Mon, 31 Jul 2023 08:08:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFC410DF
        for <rcu@vger.kernel.org>; Mon, 31 Jul 2023 05:07:57 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbea14700bso41132965e9.3
        for <rcu@vger.kernel.org>; Mon, 31 Jul 2023 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690805276; x=1691410076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RtmERFMlZOzYX/xBspxMX5ThTF00TCl7wQ49mzpQ0/E=;
        b=ckvKa3Zx6KLTC/M6VWdrDZz/SSn75QqFRlMc0INiSsSBx74N0XLvwMHXr/+1kT27eP
         2VJgFZt4x2XA8zK/QCSOllF4qlJL0zdlWeiSenxoo5XA6bg0BWmo4iAsdwWj5iJRGauk
         wDEn65j7MAM1S5M1tIugT7l19Cfb4tdy6ef+XqorZf5v2By4dSwzVTenowDcofckzNyO
         K3OktzO+ncq6RAs2ijzNHWsQJJW4olboxJSVETmXZPSjGFq7VH+zra5n0r2r2pTXta7N
         Q1Jy7aFI41e+av0nqqcbhUAS0OF7+1gTr+jZqBOc0NfGDi0XeErtkvl+rKkCg5HXkczs
         4qsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690805276; x=1691410076;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtmERFMlZOzYX/xBspxMX5ThTF00TCl7wQ49mzpQ0/E=;
        b=DUOuaLuMEcRlR2DLI1uyLi6EmxQbg5mDyTbk1h6a4SO9j4lb80h8b8tBgbPiO44q4D
         fLV7i5VYc9l3J96P4BrqjSjNMWpREKkiDgFZEushKLqst/oS+ykqLxSxzXvru8kjtpc7
         SENEg/Alugk99MWseeDspm9i8ol3tKBWXYDRyrxz2qfyxoC8o2NvUYZ/gSwokZIeooSP
         eyA2BEcs82dza8LlUTyWs4NinCI+V2V5IbN3HL3iP+v9zptWJrQW6zOxmOhUC1Vjc4Nb
         oUoWoUDHnPGAdPVElup0WaZLCGtGSFRb7bsg6ndsPnw62TZQ7CgCk5hnfAGp7YsMKOTa
         ZuQQ==
X-Gm-Message-State: ABy/qLaKHthRlSqlj0D/SbSRbJ5Rgg9p+NDDz3rw2mc5P3uc7f5uQGd7
        2TozlHm28l26IOdi6awpuGufWQ==
X-Google-Smtp-Source: APBJJlFr6e04BsmGj0Si0aJ/H+RJXUxKxJY/Gls37u74uRa2g6gDjuh0SZ+KHpB0+aEfGznvQoXMRw==
X-Received: by 2002:a5d:6889:0:b0:313:f548:25b9 with SMTP id h9-20020a5d6889000000b00313f54825b9mr6424281wru.40.1690805275895;
        Mon, 31 Jul 2023 05:07:55 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q15-20020a7bce8f000000b003fe20533a1esm3193045wmj.44.2023.07.31.05.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 05:07:55 -0700 (PDT)
Date:   Mon, 31 Jul 2023 15:07:52 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH v2 06/20] tracing/filters: Optimise scalar vs cpumask
 filtering when the user mask is a single CPU
Message-ID: <04f20e58-6b24-4f44-94e2-0d12324a30e4@kadam.mountain>
References: <20230720163056.2564824-1-vschneid@redhat.com>
 <20230720163056.2564824-7-vschneid@redhat.com>
 <20230729155547.35719a1f@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230729155547.35719a1f@rorschach.local.home>
Precedence: bulk
List-ID: <rcu.vger.kernel.org>
X-Mailing-List: rcu@vger.kernel.org

On Sat, Jul 29, 2023 at 03:55:47PM -0400, Steven Rostedt wrote:
> > @@ -1761,6 +1761,11 @@ static int parse_pred(const char *str, void *data,
> >  				FILTER_PRED_FN_CPUMASK;
> >  		} else if (field->filter_type == FILTER_CPU) {
> >  			pred->fn_num = FILTER_PRED_FN_CPU_CPUMASK;
> > +		} else if (single) {
> > +			pred->op = pred->op == OP_BAND ? OP_EQ : pred->op;
> 
> Nit, the above can be written as:
> 
> 			pred->op = pret->op != OP_BAND ? : OP_EQ;
> 

Heh.  Those are not equivalent.  The right way to write this is:

	if (pred->op == OP_BAND)
		pred->op = OP_EQ;

regards,
dan carpenter

