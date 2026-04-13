Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0407239524D
	for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 07:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776066257; cv=none; b=dc6YZbB4UMkrFFG1uHiWz0NdM2Gep97ZOmalE6oqhG2wBh8xxsqt3EWGp1GKOv6JSqTFKQ8ED9mi65T9XmggCEFI3skKyKLwZYl0oDtOeXWeM/DV68i9BJxiGgambKK+SJwhM+og0GFYDLLm4Wr8TstNM3cEw+P+uDr8btfSk9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776066257; c=relaxed/simple;
	bh=abNstHmJGgw4JbpWqL555msiifzgY+9+aN3eQVlKCX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/MAG7qkBuo4bQ0GHAzuIJECHZehvEmqZn+1ytyMX1mETEZ+OiupKpnk6X4H7d5wYXFZygbAaeVrBpUE/3sGFLMm0XTVrDKSOFSorFbY8KKsofkBiZ+nK+zv/piN1W8PnTYH4uzXL1Jw+cKxR+10N0szKV8n9XtRBipfPWh0ntg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfXeGHxD; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfXeGHxD"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c1fcce8f8so6903827c88.1
        for <rcu@vger.kernel.org>; Mon, 13 Apr 2026 00:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776066255; x=1776671055; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EF3HsX1PiWlQS1SWUgySjoqh/zlAKHa5r5Dv0SN822Y=;
        b=OfXeGHxDXjLlvoZJQLl2fIyr2B7Ezrmrc+Ir2bzbbK7z4cugW2V3aOao4CC1jCFf9/
         KkiyEWtA9IQ61ZMNyufOzSeQlYQn12b5HoZujPMJGD/QijERHfLBqXfuuebIhGseJ/sc
         HqRHyx9DrQFL1QQ3tGiLfAQiLQj969T+3JE/bnRN/O0bdfd3eJhHhPQ+g8MfVPWjclpw
         i1y4fo+fzljdwsDlavcuqNQAQ9sTfWraQVCDFDGa78J6daPlwai6hkt+hqdV/MP0eaPp
         vTaHIpac17q+ITfiX9s9Q4AVTfZBMhv0g0GuryusQ1pOLZpnaPsSVhVvxtsKJ9VMJG3c
         bT9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776066255; x=1776671055;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EF3HsX1PiWlQS1SWUgySjoqh/zlAKHa5r5Dv0SN822Y=;
        b=FEn0bORC9B8WIXbvy3oyUk3DlM7yuYWyLwXr6d8eBWBcUq79a03BFrsdDGYHs2Kr4+
         8RKUF6b4K4Xhqlh0LjCsT4E21Q6IrgsRfSHF59W8Q7JKM3EVrUpHC/I6B/ZDhfcHIQFd
         uYQoUHhVKf+C3pejrShRPumPVbmK0bAoEE9RDBUEZ2H68yVuYF9OwG9NOjKX+i84dB7y
         BMMu1rhWnWtDrJXUEthQ9HJguprCeVmpDTvGOeuk6xfgYXttj89w67k69ZmVyhDOocU9
         8hBphmezRT1miZpJl7na5+1/mLekljof0GGHgXcSUVF5Upt0CYExfTb2idFv6GeSABdi
         LsgA==
X-Forwarded-Encrypted: i=1; AFNElJ8pFWqPrhSDl++7jq9hdskqcRQ1cKeJdkkuKb7T2NLbh+KmgDC3Eq6mKug79jhdDPGosGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXitmd2YouUEFWyAjo2SzJslmBK4NCgFmX8FoKb/qNxB8prK0d
	tCWQRyrvc4B9EJ6XsPNuZH8sZ2bjHDA2mPr+zYfdjmxif/DNIoEXqfsK
X-Gm-Gg: AeBDieuaaAYUPFJ1MiN4tPR2GxMXVfSMcO4cQrLgukclMAvVygJNKGn7/1+KDCFRaAY
	YPo3euUpe1QDwLigHzvXBBDNCUp3Eya3dk04NkilkrVJsNIEwz512Q2roTEV33lZwqM3Ht0E5DU
	FIrNIMhqqBkc3owbWENiSAwbfqMazZbjqlvZzh1WEJeDnHtqOQHqxewkNHqFWmp3b2EtcYMZ5QW
	WbjzNwcD5j9dAf+qAPnDnUpDfe7l7xO7E+Zh2G4/nRo6jZjGPyB0cH0vkzkYuOOuVCAwMmOJMON
	KNGtVmub2QQviAcLwvMdSgVVuhKggKuMWrJVJtzfevvX8mHs8WxbfArI8OkGkmsptlkbw3EKfOy
	KHQrRsquSypdwcxF6Hffegr35JzcHimO1ccTXAAoGHxISA25WG+9E1WWNaCEHmiY82JeCyOXrZ4
	B9nRAY/7SzZCLfLpJi0S8+Sp56cOY=
X-Received: by 2002:a05:7022:47:b0:128:d4be:7428 with SMTP id a92af1059eb24-12c34edee4bmr7057521c88.19.1776066255198;
        Mon, 13 Apr 2026 00:44:15 -0700 (PDT)
Received: from wujing. ([74.48.213.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c347fa2c9sm12884610c88.15.2026.04.13.00.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 00:44:14 -0700 (PDT)
From: Qiliang Yuan <realwujing@gmail.com>
Date: Mon, 13 Apr 2026 15:43:11 +0800
Subject: [PATCH v2 05/12] genirq: Support dynamic migration for managed
 interrupts
Precedence: bulk
X-Mailing-List: rcu@vger.kernel.org
List-Id: <rcu.vger.kernel.org>
List-Subscribe: <mailto:rcu+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:rcu+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-wujing-dhm-v2-5-06df21caba5d@gmail.com>
References: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
In-Reply-To: <20260413-wujing-dhm-v2-0-06df21caba5d@gmail.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <jackmanb@google.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
 Waiman Long <longman@redhat.com>, Chen Ridong <chenridong@huaweicloud.com>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org, linux-mm@kvack.org, 
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <realwujing@gmail.com>
X-Mailer: b4 0.13.0

Managed interrupts currently have their affinity determined once,
honoring boot-time isolation settings. There is no mechanism to migrate
them when housekeeping boundaries change at runtime.

Enable managed interrupts to respond dynamically to housekeeping updates.

This ensures that managed interrupts are migrated away from newly
isolated CPUs or redistributed when housekeeping CPUs are added.

Signed-off-by: Qiliang Yuan <realwujing@gmail.com>
---
 kernel/irq/manage.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2e80724378267..31e263d9f40d0 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2801,3 +2801,52 @@ bool irq_check_status_bit(unsigned int irq, unsigned int bitmask)
 	return res;
 }
 EXPORT_SYMBOL_GPL(irq_check_status_bit);
+
+#ifdef CONFIG_SMP
+static int irq_housekeeping_reconfigure(struct notifier_block *nb,
+				       unsigned long action, void *data)
+{
+	struct housekeeping_update *upd = data;
+	unsigned int irq;
+
+	if (action != HK_UPDATE_MASK || upd->type != HK_TYPE_MANAGED_IRQ)
+		return NOTIFY_OK;
+
+	irq_lock_sparse();
+	for_each_active_irq(irq) {
+		struct irq_data *irqd;
+		struct irq_desc *desc;
+
+		desc = irq_to_desc(irq);
+		if (!desc)
+			continue;
+
+		scoped_guard(raw_spinlock_irqsave, &desc->lock) {
+			irqd = irq_desc_get_irq_data(desc);
+			if (!irqd_affinity_is_managed(irqd) || !desc->action ||
+			    !irq_data_get_irq_chip(irqd))
+				continue;
+
+			/*
+			 * Re-apply existing affinity to honor the new
+			 * housekeeping mask via __irq_set_affinity() logic.
+			 */
+			irq_set_affinity_locked(irqd, irq_data_get_affinity_mask(irqd), false);
+		}
+	}
+	irq_unlock_sparse();
+
+	return NOTIFY_OK;
+}
+
+static struct notifier_block irq_housekeeping_nb = {
+	.notifier_call = irq_housekeeping_reconfigure,
+};
+
+static int __init irq_init_housekeeping_notifier(void)
+{
+	housekeeping_register_notifier(&irq_housekeeping_nb);
+	return 0;
+}
+core_initcall(irq_init_housekeeping_notifier);
+#endif

-- 
2.43.0

